import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Init
    private let imageView: UIImageView = {
        let image = UIImage(named: "avatar.png")
        let imageView = UIImageView(image: image)
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
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = .ypGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let userDescription: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .ypWhite
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Visible subviews
    private func setupViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(userDescription)
        view.addSubview(logoutButton)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        // init
        var constraints = [NSLayoutConstraint]()
        
        // add
        // imageview constraints
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: 70))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 70))
        constraints.append(imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32))
        constraints.append(imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        
        // name label constraints
        constraints.append(nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8))
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor))
        
        // username label constraints
        constraints.append(usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8))
        constraints.append(usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        
        // description constraints
        constraints.append(userDescription.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8))
        constraints.append(userDescription.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        
        // logout button constraints
        constraints.append(logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45))
        
        // activate
        NSLayoutConstraint.activate(constraints)
    }
}
