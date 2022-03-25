import Foundation
import UIKit

extension UIView {
    /// Reuse identifiers especially for table and collection view cells
    static var kReuseIdentifier: String {
        return String(describing: self)
    }
    /// Nib used to register cells for table/collection view
    static var kUINib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}

extension UIViewController {
    /// Storyboard identifier to initalize storyboards
    static var storyboardIdentifier: String? {
        return String(describing: self)
    }
}
