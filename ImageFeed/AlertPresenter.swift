import UIKit

final class AlertPresenter {
    weak var delegate: UIViewController?
    
    func showAlert(title: String, message: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            handler()
        }
        
        alert.addAction(action)
        delegate?.present(alert, animated: true)
    }
}
