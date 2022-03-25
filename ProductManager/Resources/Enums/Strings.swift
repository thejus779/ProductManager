import Foundation

enum L10n {
    
    enum Common {
        static let error = "common.error".localized()
        static let noinfo = "common.noinfo".localized()
        static let yes = "common.yes".localized()
        static let no = "common.no".localized()
        enum Button {
            static let ok = "common.button.ok".localized()
        }
        enum Error {
            static let coding = "common.error.coding".localized()
            static let noData = "common.error.noData".localized()
            static let unknown = "common.error.unknown".localized()
            static let serverError = "common.error.serverError".localized()
        }
    }
    enum Searchproductsviewcontroller {
        enum Field {
            static let placeholder = "searchproductsviewcontroller.field.placeholder".localized()
        }
        enum Label {
            static let nodata = "searchproductsviewcontroller.label.nodata".localized()
            static let search = "searchproductsviewcontroller.label.search".localized()
        }
    }
    enum Productdetailsviewcontroller {
        static let title = "productdetailsviewcontroller.title".localized()
        enum Label {
            static let name = "productdetailsviewcontroller.label.name".localized()
            static let cost = "productdetailsviewcontroller.label.cost".localized()
            static let info = "productdetailsviewcontroller.label.info".localized()
        }
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
