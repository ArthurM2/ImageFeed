import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usertagLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func tapLogoutButton(_ sender: Any) {
        print("✅button pressed🍏")
    }
    
    // MARK: - StatusBar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
}
