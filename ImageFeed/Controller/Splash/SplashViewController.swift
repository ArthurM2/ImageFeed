import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Private properties
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let authService = OAuth2Service()
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let alertPresenter = AlertPresenter()
    private var wasChecked: Bool = false
    
    private lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "auth_screen_logo")
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter.delegate = self
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuthStatus()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        view.addSubview(splashImageView)
        
        NSLayoutConstraint.activate([
            splashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.heightAnchor.constraint(equalToConstant: 75),
            splashImageView.heightAnchor.constraint(equalToConstant: 78)
        ])
    }
    
    // MARK: - Private methods
    private func checkAuthStatus() {
        guard !wasChecked else { return }
        wasChecked = true
        if authService.isAuthenticated {
            UIBlockingProgressHUD.show()
            
            fetchProfile { [weak self] in
                UIBlockingProgressHUD.dismiss()
                self?.switchToTabBarController()
            }
        } else {
            presentAuth()
        }
    }
    
    private func presentAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "AuthViewController")
        
        guard let authViewController = vc as? AuthViewController else { return }
        authViewController.delegate = self
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
           
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchAuthToken(code)
        }
    }

    private func fetchAuthToken(_ code: String) {
        UIBlockingProgressHUD.show()
        
        authService.fetchAuthToken(code) { [weak self] authResult in
            switch authResult {
            case .success(_):
                self?.fetchProfile(completion: {
                    UIBlockingProgressHUD.dismiss()
                })
            case .failure(let error):
                self?.showLoginAlert(error: error)
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    private func fetchProfile(completion: @escaping () -> Void) {
        profileService.fetchProfile { [weak self] profileResult in
            switch profileResult {
            case .success(_):
                self?.switchToTabBarController()
            case .failure(let error):
                self?.showLoginAlert(error: error)
            }
            
            completion()
        }
    }
    
    private func showLoginAlert(error: Error) {
        alertPresenter.showAlert(title: "Упс! Что-то пошло не так :(", message: "Не удалось авторизоваться, \(error.localizedDescription)") {
            self.performSegue(withIdentifier: self.showAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
}

