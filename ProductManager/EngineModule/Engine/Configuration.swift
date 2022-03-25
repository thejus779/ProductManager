import Foundation

struct Configuration {
    var baseUrl: URL {
        guard let url = URL(string: "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com") else { fatalError() }
        return url
    }
}
