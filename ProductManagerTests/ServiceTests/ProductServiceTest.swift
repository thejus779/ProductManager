import XCTest
@testable import ProductManager

class ProductServiceTest: XCTestCase {
    let engine = Engine(
        configuration: Configuration()
    )
    
    func testSearchProductService() {
        let expectation = self.expectation(description: "testSearchProductService")
        engine.productService.searchProducts(
            with: TestUtils.searchQuery,
            pageNo: 1
        ){ result in
            switch result {
            case .success(let ds):
                XCTAssertFalse(ds.products.isEmpty)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
