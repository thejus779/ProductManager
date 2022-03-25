import Foundation

class ProductsCellViewModel {
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var imageUrl: URL? { URL(string: product.productImage ?? "") }
    var productName: String { product.productName }
    var isDeliveredNextDay: Bool { product.nextDayDelivery ?? false }
    var deliveryStatusLabel: String {
        "Next Day Delivery: \(isDeliveredNextDay ? L10n.Common.yes : L10n.Common.no)"
    }
}
