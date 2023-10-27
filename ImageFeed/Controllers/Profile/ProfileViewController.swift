import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    // MARK: - Private variables
    private let profileImageService = ProfileImageService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private let profileService = ProfileService.shared
    
    // MARK: - Init views
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhite
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let loginNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = .ypGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .ypWhite
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "ExitButton")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .ypRed
        
        return button
    }()
    
    @objc func didTapButton() {
        print("Test tap button!")
    }
    
    // MARK: - StatusBar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateAvatar()
        }
        updateAvatar()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUserDetails()
    }
    
    
    // MARK: - Private Methods
    private func updateAvatar() {
        guard let profileImageURL = profileImageService.avatarURL,
              let url = URL(string: profileImageURL) else {
//            assertionFailure("Didnt get profileImageURL")
            return
        }
        let processor = RoundCornerImageProcessor(cornerRadius: 61)
        profileImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "AvatarStub"),
            options: [.processor(processor)])
    }
        
    private func updateUserDetails() {
        guard let profile = profileService.profile else {
            assertionFailure("Profile failure, couldn't save")
            return
        }
        
        self.nameLabel.text = profile.name
        self.descriptionLabel.text = profile.bio
        self.loginNameLabel.text = profile.loginName
    }
        
    // MARK: - Visible subviews
    private func setupViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(logoutButton)
    }
        
    // MARK: - Constraints
    private func setupConstraints() {
        // init
        var constraints = [NSLayoutConstraint]()
        
        // add
        // imageview constraints
        constraints.append(profileImageView.widthAnchor.constraint(equalToConstant: 70))
        constraints.append(profileImageView.heightAnchor.constraint(equalToConstant: 70))
        constraints.append(profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
            
        // name label constraints
        constraints.append(nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8))
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor))
        
        // username label constraints
        constraints.append(loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8))
        constraints.append(loginNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        
        // description constraints
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: logoutButton.trailingAnchor))
            
        // logout button constraints
        constraints.append(logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
            constraints.append(logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45))
            
        // activate
        NSLayoutConstraint.activate(constraints)
        }
}
