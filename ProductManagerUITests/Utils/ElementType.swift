import XCTest

enum ElementType {
    case image
    case searchField
    case cells

    init?(_ text: String) {
        if XCUIApplication().images[text].exists {
            self = .image
        } else if XCUIApplication().searchFields[text].exists {
            self = .searchField
        } else if XCUIApplication().cells[text].exists {
            self = .cells
        } else {
            return nil
        }
    }

    func getElement(with text: String) -> XCUIElement {
        switch self {
        case .image:
            return XCUIApplication().images[text]
        case .searchField:
            return XCUIApplication().searchFields[text]
        case .cells:
            return XCUIApplication().cells[text]
        }
    }
}
