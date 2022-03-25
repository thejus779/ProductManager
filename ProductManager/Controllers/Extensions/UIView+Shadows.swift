import Foundation
import UIKit

struct ShadowStyle {
    let opacity: Float
    let offset: CGFloat
    let radius: CGFloat
    
    static let medium = ShadowStyle(opacity: 0.3, offset: 3, radius: 5)
}

extension UIView {
    /// Set shadow style to drop shadows for a view
    var shadowStyle: ShadowStyle {
        get {
            return ShadowStyle(
                opacity: self.layer.shadowOpacity,
                offset: self.layer.shadowOffset.height,
                radius: self.layer.shadowRadius
            )
        }
        set {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = newValue.opacity
            self.layer.shadowOffset = CGSize(width: 0, height: newValue.offset)
            self.layer.shadowRadius = newValue.radius
        }
    }
}

