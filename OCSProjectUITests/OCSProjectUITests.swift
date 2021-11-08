//
//  OCSProjectUITests.swift
//  OCSProjectUITests
//
//  Created by Anis on 02/11/2021.
//

import XCTest

class OCSProjectUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ForOpeningSearchTextField_ThenCancel () throws {
        app.launch()
        
        let motsClSSearchField = app.navigationBars["OCSProject.SearchView"].searchFields["Mots clés"]
        motsClSSearchField.tap()
        
        app.navigationBars["OCSProject.SearchView"].buttons["Cancel"].tap()
    }
    
    func test_OpenFirstCell_ThenBackToSearch () throws {
        app.launch()
        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
        guard firstChild.exists else {return}
        firstChild.tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    func test_forSearchForLettersSPI_TouchFirstCell_AndOpenVideo_ThenCloseIt_ThenBackToSearch() throws {
        app.launch()
        
        let motsClSSearchField = app.navigationBars["OCSProject.SearchView"].searchFields["Mots clés"]
        motsClSSearchField.tap()
        
        let gKey = app.keys["G"]
        gKey.tap()
        let aKey = app.keys["a"]
        aKey.tap()
        let mKey = app.keys["m"]
        mKey.tap()
        let eKey = app.keys["e"]
        eKey.tap()
        
        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
        guard firstChild.exists else {return}
        firstChild.tap()
        app.scrollViews.otherElements.buttons["play"].tap()
        app.buttons["Done"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func test_OnlyOpenVideo_ThenCloseIt () throws {
        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
        guard firstChild.exists else {return}
        firstChild.tap()
        app.scrollViews.otherElements.buttons["play"].tap()
        app.buttons["Done"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
