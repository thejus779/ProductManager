import Foundation

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
