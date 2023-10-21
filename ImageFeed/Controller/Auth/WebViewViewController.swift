import UIKit
import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController {
    private var estimatedProgressObservation: NSKeyValueObservation?
    weak var delegate: WebViewViewControllerDelegate?
    
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
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = .ypBlack
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        webView.navigationDelegate = self
        setupInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 self.updateProgress()
             })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    
    @objc func backButtonPressed() {
        delegate?.webViewViewControllerDidCancel(self)
    }
    
    // MARK: - Setup
    private func setupView() {
        webView.backgroundColor = .ypWhite
        
        view.addSubview(webView)
        view.addSubview(backwardButton)
        view.addSubview(progressView)
    }
    
    private func setupInit() {
        setupView()
        setupLayout()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        var constraints = [NSLayoutConstraint]()
        // webview
        constraints.append(webView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(webView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(webView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(webView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        
        // progressView
        constraints.append(progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(progressView.topAnchor.constraint(equalTo: backwardButton.bottomAnchor, constant: 2))
        
        // button
        constraints.append(backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11))
        constraints.append(backwardButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.allow)
        } else {
            decisionHandler(.allow)
        }
    }  
}

private extension WebViewViewController {
    func loadWebView() {
        var urlComponents = URLComponents(string: Constants.unsplashAuthorizeURLString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: Constants.accessScope)]
        
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            webView.load(request)
            updateProgress()
        }
    }
    
    func code(from navigationAction: WKNavigationAction) -> String? {
        if let url = navigationAction.request.url,
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
