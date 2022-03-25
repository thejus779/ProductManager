import XCTest
@testable import ProductManager

class ProductDetailsViewModelTests: XCTestCase {
    let engine = Engine(
        configuration: Configuration(),
        productService: MockProductService(networkClient: nil)
    )
    
    func testPaginationLoad() {
        
        if let product = engine.productService.loadMockedData().products.first {
            let viewModel = ProductDetailsViewModel(product: product)
            XCTAssertFalse(viewModel.displayableInfos.isEmpty)
            if let url = viewModel.imageUrl {
                XCTAssertTrue(url.absoluteString == product.productImage)
            }
        } else {
            XCTFail()
        }
    }

}
