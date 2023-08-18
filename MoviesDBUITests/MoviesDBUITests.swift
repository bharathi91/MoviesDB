//
//  MoviesDBUITests.swift
//  MoviesDBUITests
//
//  Created by Bharathi Kumar on 15/08/23.
//

import XCTest
@testable import MoviesDB

final class MoviesDBUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
       // app.activate()
        //app.launch()
        //  app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//    func testSelectingMeeting() {
//        let app = XCUIApplication()
//        app.launch()
//        app.tables.cells.firstMatch.tap()
//       // XCTAssertTrue(app.navigationBars["tableview"].exists)
//    }
    func testWaitTotap() {
        func testSelectingMeeting() {
            let app = XCUIApplication()
            app.launch()
            let cell = app.tables.cells.firstMatch
            XCTAssertTrue(cell.waitForExistence(timeout: 2))
            cell.tap()
            XCTAssertTrue(app.navigationBars["tableview"].exists)
        }
    }
    
    func testCellTap() {
        app.launch()
        let cell = app.tables["tableview"].cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        cell.tap()
    }
    
    func testSelectingMeeting() {
            let app = XCUIApplication()
            app.launch()
            let cell = app.tables["tableview"].cells.firstMatch
            XCTAssertTrue(cell.waitForExistence(timeout: 10))

            // Capture the cell's title text:
            let titleLabel = cell.staticTexts["James"]
            let meetingTitle = titleLabel.label
            XCTAssertFalse(meetingTitle.isEmpty)
            cell.tap()
            let nextScreenLabel = app
                .otherElements["tableview"]
                .staticTexts[meetingTitle]
            XCTAssertTrue(nextScreenLabel.exists)
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
