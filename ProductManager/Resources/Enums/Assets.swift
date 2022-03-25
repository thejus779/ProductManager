import Foundation
import UIKit

internal enum Assets {
    internal static let productPlaceholder = ImageAsset(name: "icon_product_placeholder")
}

internal struct ImageAsset {
    internal fileprivate(set) var name: String
    internal var image: UIImage {
        let image = UIImage(named: name, in: Bundle.main, compatibleWith: nil)
        guard let result = image else {
            fatalError("Unable to load image named \(name).")
        }
        return result
    }
}
