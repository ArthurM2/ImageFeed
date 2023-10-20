import UIKit

final class ProfileService {
    
    // MARK: - Private variables
    private(set) var profile: Profile?
    
    static let shared = ProfileService()
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
    }
}
