import Foundation
import UIKit

extension UIViewController {
    /// Show a native alert view...
    ///
    /// - Parameter:
    ///   - title: ...with this title...
    ///   - message: ...and this message
    func presentAlert(title: String? = L10n.Common.error, message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: L10n.Common.Button.ok, style: .destructive, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: completion)
    }

}
