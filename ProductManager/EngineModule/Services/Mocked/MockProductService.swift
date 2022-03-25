import Foundation

class MockProductService: ProductService {
    
    var networkClient: PNetworkClient?
    var searchProductsDataTask: URLSessionDataTask?
    
    required init(networkClient: PNetworkClient?) {}
    
    func searchProducts(with query: String, pageNo: Int, completion: @escaping ResultCallback<ProductResponse>) {
        completion(.success(loadMockedData()))
    }
    
    // Nothing to cancel in mocked state
    func cancelAnyOngoingRequest() {}
    
    func loadMockedData() -> ProductResponse {
        let mockedProducts = "product_list"
        do {
            return try JsonLoader().loadResourceJson(filename: mockedProducts, to: ProductResponse.self)
        } catch {
            fatalError("Failed to load file named \(mockedProducts)")
        }
    }
    
}
