import Foundation
import UIKit

/// View controllers that can be instanciated from storyboard
protocol Spawnable {
        
    /// Instanciate a view controller
    static func spawn() -> Self
    
    /// Defaults to the class name of the view controller
    static var storyboardName: String? { get }
    
    /// If nil, will instantiate the initial view controller
    static var storyboardIdentifier: String? { get }

}

extension Spawnable {
    static var storyboardName: String? { return nil }
    static var storyboardIdentifier: String? { return nil }
}

extension Spawnable where Self: UIViewController {
    static func spawn() -> Self {
        
        // Try a storyboard
        var controller: Self?
        
        let storyboardName = self.storyboardName ?? String(describing: self)
        if Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
            
            // Try an explicit identifier within the storyboard
            if let storyboardIdentifier = storyboardIdentifier {
                guard let instance = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
                    fatalError("Storyboard \(storyboardName) has no view controller with identifier \(storyboardIdentifier).")
                }
                controller = instance
            } else {
                guard let instance = storyboard.instantiateInitialViewController() as? Self else {
                    fatalError("Storyboard \(storyboardName) has no initial view controller defined.")
                }
                controller = instance
            }
        }
        
        // Simple initialization
        if let controller = controller {
            return controller
        } else {
            return self.init()
        }
    }
}
