import XCTest
@testable import ProductManager

class SearchProductsViewModelTests: XCTestCase {
    let engine = Engine(
        configuration: Configuration()
    )
    var products: [Product] = []
    lazy var viewModel = SearchProductsViewModel(engine: engine)
    
    func testSearch() {
        let expectation = self.expectation(description: "testSearch")
        viewModel.searchProducts(
            with: TestUtils.searchQuery
        ){ [weak self] result in
            guard let self = self else { fatalError() }
            switch result {
            case .success:
                XCTAssertFalse(self.viewModel.searchedProducts.isEmpty)
            case .failure:
                // Failed to load mocked data
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        loadMore(previousCount: viewModel.searchedProducts.count)
    }
    func loadMore(previousCount: Int) {
        let expectation = self.expectation(description: "loadMore")
        viewModel.loadMoreProducts(completion: { [weak self] error in
            guard let self = self else { fatalError() }
            XCTAssertNil(error)
            XCTAssertTrue(self.viewModel.searchedProducts.count > previousCount)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
