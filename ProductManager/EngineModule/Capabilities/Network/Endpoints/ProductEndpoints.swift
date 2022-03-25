import Foundation

enum ProductEndpoint: EndpointType {
    case searchProducts
    
    var path: String {
        switch self {
        case .searchProducts:
            return "/mobile-assignment/search"
        }
    }
    
    var verb: HTTPVerb {
        switch self {
        case .searchProducts:
            return .get
        }
    }
}
