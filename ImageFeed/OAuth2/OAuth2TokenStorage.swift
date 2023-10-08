import UIKit

final class OAuth2TokenStorage {
    private let bearerToken = "BearerToken"
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: bearerToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bearerToken)
        }
    }
}
