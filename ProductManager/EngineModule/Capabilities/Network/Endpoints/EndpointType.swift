import Foundation
/* Confirm all end points to EndpointType */
protocol EndpointType {
    var path: String { get }
    var verb: HTTPVerb { get }
}

// MARK: - Http verbs
enum HTTPVerb: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
