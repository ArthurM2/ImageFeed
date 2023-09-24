import UIKit
import WebKit

fileprivate let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

final class WebViewViewController: UIViewController {
    
    // MARK: - Init
    private let backwardButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "Backward")!,
            target: self,
            action: #selector(backButtonPressed))
        button.tintColor = .ypBlack
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .ypWhite
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUrl()
        setupView()
        setupLayout()
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    // MARK: - Setup
    private func setupView() {
        webView.backgroundColor = .ypWhite
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        view.addSubview(backwardButton)
    }

    private func configUrl() {
        var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: AccessKey),
            URLQueryItem(name: "redirect_uri", value: RedirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: AccessScope)
        ]
        guard let url = urlComponents.url else { return }

        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func setupInit() {
        configUrl()
        setupView()
        setupLayout()
    }
    
    private func setupLayout() {
        var constraints = [NSLayoutConstraint]()
        // webview
        constraints.append(webView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(webView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(webView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(webView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        
        // button
        constraints.append(backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11))
        constraints.append(backwardButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            //TODO: proccess code
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
