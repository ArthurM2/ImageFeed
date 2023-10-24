import UIKit

final class ProfileImageService {
    private var currentTask: URLSessionTask?
    private var session = URLSession.shared
    private(set) var avatarURL: String?
    private let builder: URLRequestBuilder
    
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    init(builder: URLRequestBuilder = .shared) {
        self.builder = builder
    }

    
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        currentTask?.cancel()
        
        guard let request = fetchProfileImage(username: username) else { return }

        currentTask = session.object(for: request) {
            [weak self] (response: Result<ProfileResult, Error>) in
            self?.currentTask = nil            
            guard let self = self else { return }
            switch response {
            case .success(let profilePhoto):
                guard let mediumPhoto = profilePhoto.profileImage?.medium else { return }
                self.avatarURL = mediumPhoto
                completion(.success(mediumPhoto))
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotification,
                    object: self,
                    userInfo: ["URL": mediumPhoto]
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchProfileImage(username: String) -> URLRequest? {
        builder.makeHTTPRequest(
            path: "/users/\(username)",
            httpMethod: "GET",
            baseURLString: Constants.defaultBaseApiURLString
        )
    }
}
