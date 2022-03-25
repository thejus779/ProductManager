import Foundation
import TLogger

class SearchProductsViewModel {
    private let engine: Engine
    var previousSearchResponse: ProductResponse?
    var searchedProducts: [Product] = []
    var searchedQuery: String = ""
    
    init(engine: Engine) {
        self.engine = engine
    }
    
    // Searches for the given string
    func searchProducts(with query: String, completion: @escaping ResultCallback<ProductResponse>)  {
        self.searchedQuery = query
        guard !searchedQuery.isEmpty else {
            completion(.failure(PError.noData))
            return
        }
        engine.productService.searchProducts(with: query, pageNo: 1) { [weak self] result in
            switch result {
            case .success(let productResponse):
                self?.previousSearchResponse = productResponse
                self?.searchedProducts = productResponse.products
            default: break
            }
            completion(result)
        }
    }

    // Completion with a finished Bool state to indicate finished loading all data
    func loadMoreProducts(completion: @escaping (Error?) -> Void )  {
        guard previousSearchResponse?.currentPage ?? 0 < previousSearchResponse?.pageCount ?? 0
        else {
            // All data loaded alraedy
            LOG("All products loaded already", .likeABoss)
            completion(nil)
            return
        }
        let pageNo = (previousSearchResponse?.currentPage ?? 1) + 1
        engine.productService.searchProducts(with: searchedQuery, pageNo: pageNo) { [weak self] result in
            switch result {
            case .success(let newResponse):
                self?.previousSearchResponse = newResponse
                self?.searchedProducts.append(contentsOf: newResponse.products)
                LOG("Added \(newResponse.products.count) more products", .info)
                completion(nil)
            case .failure(let error):
                LOG("Failed with error \(error)", .error)
                completion(error)
            }
        }
    }
   
    // Reset search result
    func reset() {
        searchedProducts = []
        searchedQuery = ""
        previousSearchResponse = nil
        engine.productService.cancelAnyOngoingRequest()
    }
}
