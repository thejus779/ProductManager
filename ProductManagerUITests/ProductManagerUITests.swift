//
//  ProductManagerUITests.swift
//  ProductManagerUITests
//
//  Created by Thejus Thejus on 24/03/2022.
//

import XCTest

class ProductManagerUITests: XCTestCase {

    // Create an Instance of the app
    let app = XCUIApplication()

    // Launch the instance of the app
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }


    func testSearch() {

        // Check if the search field exisits, and tap and edit
        XCTAssertTrue(SearchUI.searchProductsSearchField.element.exists)
        SearchUI.searchProductsSearchField.element.tap()
        SearchUI.searchProductsSearchField.element.typeText(UITestUtils.searchQuery)
        
        // Atleats 1 element in table
        XCTAssertTrue(
            app.tables.cells.element(boundBy: 0).waitForExistence(timeout: 15)
        )
        XCTAssertTrue(app.tables.cells.count > 0)
    
    }
}
enum SearchUI: String {
    case searchProductsSearchField
}

extension SearchUI {
    var type: ElementType {
        guard   let type = ElementType(self.rawValue) else {
            print("Element type for \(self.rawValue) not found")
            fatalError()
        }
        print("Type is \(type)")
        return type
    }
    var element: XCUIElement {
        return type.getElement(with: self.rawValue)
    }
}
