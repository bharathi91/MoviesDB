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
    var moviesList:NSMutableArray = []
    var counter = 0
    override func setUp() {
        continueAfterFailure = false
        app.launch()
        self.movieModalList()
        self.checkCounter()
    }
    func checkCounter() {
        if counter >= moviesList.count - 1 {
            counter = 0
        } else {
            counter = counter + 1
        }
        self.testSelectingMeeting()
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
 /*
  func testSelectingMeeting1() {
      app.launch()
      let cell = app.tables.cells.firstMatch
      XCTAssertTrue(cell.waitForExistence(timeout: 2))
      cell.tap()
      XCTAssertTrue(app.navigationBars["tableview"].exists)
  }
  
  func testCellTap() {
      app.launch()
      let cell = app.tables["tableview"].cells.firstMatch
      XCTAssertTrue(cell.waitForExistence(timeout: 10))
      cell.tap()
  }
  */
  
    
    func testSelectingMeeting() {
       
        let movie:[String:Any] = moviesList[counter] as! [String : Any]
        let movieTitle = (movie["poster_path"] as? String)!
        let cell = app.tables["tableview"].cells.staticTexts[movieTitle].firstMatch.tap()
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        checkCounter()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    func movieModalList() {
        do {
            let testBundle = Bundle(for: type(of: self))
            if let filePath = testBundle.path(forResource: "Movies", ofType: "json"),
               let jsonData = try String(contentsOfFile: filePath).data(using: .utf8) {
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                    print("JSON: \(json)")
                    if let array = json["results"] as? NSArray {
                        for movie in array {
                            //let movieData = try Movie(dictionary: movie as! [String : Any])
                            moviesList.add(movie)
                            //XCTAssertTrue(moviesList != nil)
                        }
                        print(moviesList)
                    }
                } else {
                    print("Given JSON is not a valid dictionary object.")
                }
            }
        } catch {
            print(error)
        }
    }
}
