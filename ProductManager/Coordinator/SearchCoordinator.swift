import Foundation
import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func showDetails(for product: Product)
}

class SearchCoordinator: NSObject {
    
    var navigationController: UINavigationController
    let engine: Engine
    

    init(engine: Engine) {
        self.engine = engine
        navigationController = HideBackTitleNavigationController()
        
        super.init()
                
        let searchProductsViewController = SearchProductsViewController.spawn(
            searchCoordinatorDelegate: self,
            viewModel: SearchProductsViewModel(engine: engine)
        )
        navigationController.setViewControllers([searchProductsViewController], animated: false)

    }
}

extension SearchCoordinator: SearchCoordinatorDelegate {
    func showDetails(for product: Product) {
        let productDetailsViewController = ProductDetailsViewController.spawn(
            viewModel: ProductDetailsViewModel(product: product)
        )
        navigationController.pushViewController(productDetailsViewController, animated: true)
    }
}
