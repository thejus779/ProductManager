import Foundation

class Engine {
    
    let configuration: Configuration
    
    private let networkClient: NetworkClient
    
    // Services
    let productService: ProductService
    
    
    init(
        configuration: Configuration,
        productService: ProductService? = nil,
        mockNetworkClient: PNetworkClient? = nil
    ) {
        self.configuration = configuration
        
        let networkClient = mockNetworkClient ?? PNetworkClient(
            baseUrl: configuration.baseUrl
        )
        self.networkClient = networkClient
        self.productService = productService ?? ProductNetworkService(networkClient: networkClient)
    }
}
