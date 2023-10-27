import UIKit

enum Constants {
    
    // MARK: Unsplash api paths
    static let defaultBaseApiURLString = "https://api.unsplash.com"
    static let defaultBaseURL = "https://unsplash.com"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let baseAuthTokenPath = "/oauth/token"
    
    
    // MARK: Unsplash api constants
    static let accessKey = "6X8PTmmGHmvnpTETXohW0UIaQpd4KxCjFyk9fiH7Mvg"
    static let secretKey = "AYGunk0ci1h_aJoagFgDcaLJSisWWrZcSHBXgviEU9M"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    
    // MARK: Storage constants
    static let bearerToken = "bearerToken"
}
