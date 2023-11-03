import UIKit

final class ImagesListService {
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private let session = URLSession.shared
    private var currentTask: URLSessionTask?
    private let builder: URLRequestBuilder
    private let perPage = 10
    
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    init(builder: URLRequestBuilder = .shared) {
        self.builder = builder
    }
    
    func fetchPhotosNextPage(page: Int, completion: @escaping (Result<[PhotoResult], Error>) -> Void) {
        currentTask?.cancel()
        let nextPage = lastLoadedPage == nil ? 1 : lastLoadedPage! + 1
        
        guard let request = fetchPhotosNextPageRequest(page: nextPage) else {
            fatalError("can't fetch photos pagination")
            return
        }
        
        currentTask = session.object(for: request) {
            [weak self] (response: Result<[PhotoResult], Error>) in
            self?.currentTask = nil
            guard let self = self else { return }
            switch response {
            case .success(let photoResult):
                let photo = photoResult.map { photoResult in
                return Photo(
                    id: photoResult.id,
                    size: CGSize(width: photoResult.width, height: photoResult.height),
                    createdAt: Date(),
                    welcomeDescription: photoResult.description,
                    thumbImageURL: photoResult.urls.thumb,
                    largeImageURL: photoResult.urls.full,
                    isLiked: photoResult.likedByUser
                )}
                self.photos.append(contentsOf: photo)
                self.lastLoadedPage = nextPage
                NotificationCenter.default.post(
                    name: ImagesListService.didChangeNotification,
                    object: self,
                    userInfo: ["PHOTOS": photos]
                )
                completion(.success(photoResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    private func fetchPhotosNextPageRequest(page: Int) -> URLRequest? {
        builder.makeHTTPRequest(
            path: "/photos?page=\(page)&per_page=\(perPage)",
            httpMethod: "GET",
            baseURLString: Constants.defaultBaseApiURLString
        )
    }
}

