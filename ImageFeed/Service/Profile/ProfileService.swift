import UIKit

final class ProfileService {
    
    // MARK: - Private variables
    private(set) var profile: Profile?
    private var currentTask: URLSessionTask?
    private let builder: URLRequestBuilder
    private let session = URLSession.shared
    
    static let shared = ProfileService()
    
    init(builder: URLRequestBuilder = .shared) {
        self.builder = builder
    }
    
    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        currentTask?.cancel()
        guard let request = fetchProfileRequest() else { return }
        
        currentTask = session.object(for: request) { 
            [weak self] (response: Result<ProfileResult, Error>) in
            self?.currentTask = nil
            switch response {
            case .success(let profileResult):
                let profile = Profile(result: profileResult)
                self?.profile = profile
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchProfileRequest() -> URLRequest? {
        builder.makeHTTPRequest(
            path: "/me",
            httpMethod: "GET",
            baseURLString: Constants.defaultBaseApiURLString
        )
    }
}
