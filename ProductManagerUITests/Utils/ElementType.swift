import XCTest

enum ElementType {
    case searchField

    init?(_ text: String) {
        if XCUIApplication().searchFields[text].exists {
            self = .searchField
        } else {
            return nil
        }
    }

    func getElement(with text: String) -> XCUIElement {
        switch self {
        case .searchField:
            return XCUIApplication().searchFields[text]
        }
    }
}
