import Foundation

struct ProfileResult {
    let userLogin: String
    let firstName: String?
    let lastName: String?
    let bio: String?
    
    private enum CodingKeys: String, CodingKey {
        case userLogin = "username"
        case firstName = "first_name"
        case lastNane = "last_name"
        case bio
    }
}
