import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let image = UIImage(named: "auth_screen_logo.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .ypWhite
        button.layer.cornerRadius = 16
        button.setTitleColor(.ypBlack, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .ypBlack
        view.addSubview(imageView)
        view.addSubview(authButton)
    }
    
    private func setupLayout() {
        var constraints = [NSLayoutConstraint]()
        
        // imageView constraints
        constraints.append(imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        
        // Auth button
        constraints.append(authButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90))
        constraints.append(authButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(authButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        constraints.append(authButton.heightAnchor.constraint(equalToConstant: 48))
        
        NSLayoutConstraint.activate(constraints)
    }
}
