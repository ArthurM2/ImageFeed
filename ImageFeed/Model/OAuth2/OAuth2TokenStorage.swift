import UIKit
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    private let keychain = KeychainWrapper.standard
    
    var token: String? {
        get {
            return keychain.string(forKey: Constants.bearerToken)
        }
        set {
            if let token = newValue {
                keychain.set(token, forKey: Constants.bearerToken)
            } else {
                keychain.removeObject(forKey: Constants.bearerToken)
            }
        }
    }
}
