import Foundation
import TLogger

protocol ProductService: AnyObject {
    var networkClient: PNetworkClient? { get set }
    var searchProductsDataTask: URLSessionDataTask? { get }
    
    /// Initializer
    init(networkClient: PNetworkClient?)
    
    /// Search products service call
    func searchProducts(with query: String, pageNo: Int, completion: @escaping ResultCallback<ProductResponse>)
    
    /// Cancel any open requests
    func cancelAnyOngoingRequest()
    
    /// Load mocked data from json file
    func loadMockedData() -> ProductResponse
}

class ProductNetworkService: ProductService {
    
    var networkClient: PNetworkClient?
    var searchProductsDataTask: URLSessionDataTask?
    
    required init(networkClient: PNetworkClient?) {
        self.networkClient = networkClient
    }
    
    func searchProducts(with query: String, pageNo: Int, completion: @escaping ResultCallback<ProductResponse>) {
        // 1. Cancel previous request if any, query string updated
        cancelAnyOngoingRequest()
        
        // 2. Set query and pageNo as paramters
        let parameters: [String : Any] = ["query": query, "page": pageNo]
        
        // Search request
        searchProductsDataTask = networkClient?.request(
            endpoint: ProductEndpoint.searchProducts,
            parameters: parameters,
            completion: { result in
                switch result {
                case .success(data: let data):
                    if let data = data {
                        do {
                            let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                            completion(.success(productResponse))
                            LOG("[ProductsService] products search success for query \(query)", .success)
                        } catch let error {
                            completion(.failure(error))
                            LOG("[ProductsService] products decoding error \(error)", .error)
                        }
                    } else {
                        completion(.failure(PError.unknown))
                        LOG("[ProductsService] products search error", .error)
                    }
                case .error(let error):
                    completion(.failure(error))
                    LOG("[ProductsService] products search error \(error)", .error)
                }
            }
        )
    }
    
    
    func cancelAnyOngoingRequest() {
        searchProductsDataTask?.cancel()
    }
    
    // Not used, only useful in case mocking the data, but should be done at MockService
    func loadMockedData() -> ProductResponse { ProductResponse.mockedProductResponse }
}
