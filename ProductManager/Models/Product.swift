import Foundation
struct ProductResponse: Codable {
    let products: [Product]
    let currentPage: Int
    let pageSize: Int
    let totalResults: Int
    let pageCount: Int
}
extension ProductResponse {
    static let mockedProductResponse = ProductResponse(products: [], currentPage: -1, pageSize: -1, totalResults: -1, pageCount: -1)
}

struct Product: Codable, Equatable {
    let productId: Int64
    let productName: String
    let productImage: String?
    let totalCost: Double?
    let additionalInfo: [String]
    let nextDayDelivery: Bool?

    enum CodingKeys: String, CodingKey {
        case productId
        case productName
        case productImage
        case totalCost = "salesPriceIncVat"
        case additionalInfo = "USPs"
        case nextDayDelivery
    }
    
//    "reviewInformation": {
//        "reviews": [],
//        "reviewSummary": {
//            "reviewAverage": 9.1,
//            "reviewCount": 952
//        }
//    }
}
