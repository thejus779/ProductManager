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
        search()
    }
    func testSearch1() {
        search()
    }
    func testSearch2() {
        search()
    }
    func testSearch3() {
        search()
    }
    func testSearch4() {
        search()
    }
    func testSearch5() {
        search()
    }
    func testSearch6() {
        search()
    }
    func testSearch7() {
        search()
    }
    func testSearch11() {
        search()
    }
    func testSearch22() {
        search()
    }
    func testSearc2h3() {
        search()
    }
    func testSearch34() {
        search()
    }
    func testSearc1h5() {
        search()
    }
    func testS1earch6q() {
        search()
    }
    func test2Sqweearch() {
        search()
    }
    func testSe4arch1() {
        search()
    }
    func testSear2ch2() {
        search()
    }
    func testSea1rch3() {
        search()
    }
    func test4Search4() {
        search()
    }
    func testSe2arch5() {
        search()
    }
    func testSea22rch6() {
        search()
    }

    func search() {

        // Check if the search field exisits, and tap and edit
        XCTAssertTrue(SearchUI.searchProductsSearchField.element.exists)
        SearchUI.searchProductsSearchField.element.tap()
        SearchUI.searchProductsSearchField.element.typeText(UITestUtils.searchQuery)
        
        // Atleats 1 element in table
        XCTAssertTrue(
            app.tables.cells.element(boundBy: 0).waitForExistence(timeout: 15)
        )
        XCTAssertTrue(app.tables.cells.count > 0)
        
        // Weired glitch, tableview is somehow still reloading and tap doesn't work till it's completed
        // Need to investigate, having sleep is a bad idea, could increase test time forcefully
        sleep(3)
        
        // Tap first element, if first element not avaialable already failed test
        app.tables.cells.element(boundBy: 0).tap()
        
        // Check for existence of some ui elemenent from expected ui
        XCTAssertTrue(
            SearchUI.productDetailsImageView.element.waitForExistence(timeout: 5)
        )
        XCTAssertTrue(app.tables.cells.count > 0)
    }
}
enum SearchUI: String {
    case productDetailsImageView
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
