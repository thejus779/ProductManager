import Foundation
import UIKit

extension UIActivityIndicatorView {
    /// Show loader and start spinning
    func showLoader() {
        isHidden = false
        startAnimating()
    }
    /// Hide loader 
    func hideLoader() {
        hidesWhenStopped = true
        stopAnimating()
    }
}
