import Foundation

class ProductDetailsViewModel {
    
    private let product: Product
    
    struct DisplayableInfo {
        var value: String
        var name: String
        
        var localizedString: String {
            "\(value) \(name)"
        }
    }
    
    init(product: Product) {
        self.product = product
    }
    
    var imageUrl: URL? { URL(string: product.productImage ?? "") }
    
    lazy var displayableInfos: [DisplayableInfo] = {
        let nameInfo = DisplayableInfo(
            value: L10n.Productdetailsviewcontroller.Label.name,
            name: product.productName
        )
        let costInfo = DisplayableInfo(
            value: L10n.Productdetailsviewcontroller.Label.cost,
            name: "\(product.totalCost ?? 0)"
        )
        let detailsInfo = DisplayableInfo(
            value: L10n.Productdetailsviewcontroller.Label.info,
            name: product.additionalInfo.joined(separator: ", ")
        )
        return [nameInfo, costInfo, detailsInfo]
    }()
}
