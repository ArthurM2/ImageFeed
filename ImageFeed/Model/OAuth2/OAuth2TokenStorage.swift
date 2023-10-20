import UIKit

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: Constants.bearerToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.bearerToken)
        }
    }
}
