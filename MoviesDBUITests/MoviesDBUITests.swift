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
        //self.checkCounter()
       // self.testSearchBar()
        self.testSelectingMeeting()

    }
    func checkCounter() {
        if counter >= self.moviesList.count - 1 {
            counter = 0
        } else {
            counter = counter + 1
        }
        self.testSelectingMeeting()
    }
func testEnterTextInSearchBar() {
     let app = XCUIApplication()
     app.launch()
     let searchBarElement = app.otherElements["search-bar"].firstMatch
     //let searchBarElement = app.searchFields["search-bar"].tap().firstMatch
     searchBarElement.tap()
     searchBarElement.typeText("test")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
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

extension XCUIElement {
    func clearAndEnterText(_ text: String)
        {
            guard let stringValue = self.value as? String else {
                XCTFail("Tried to clear and enter text into a non string value")
                return
            }
            self.tap()
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
            self.typeText(deleteString)
            self.typeText(text)
        }
}
extension XCUIElement {
    // The following is a workaround for inputting text in the
    //simulator when the keyboard is hidden
    func setText(text: String, application: XCUIApplication) {
        UIPasteboard.general.string = text
       // doubleTap()
        application.setText(text: "John", application: application)
    }
}


extension XCUIElement {
    
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        // workaround for apple bug
        if let placeholderString = self.placeholderValue, placeholderString == stringValue {
            return
        }
        
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
    }
    
    func typeTextAndPressEnter(_ text: String) {
        self.typeText("\(text)\n")
    }

}
extension XCUIElement {
    func clearText(andReplaceWith newText:String? = nil) {
        tap()
        tap() //When there is some text, its parts can be selected on the first tap, the second tap clears the selection
        press(forDuration: 1.0)
        let selectAll = XCUIApplication().menuItems["Select All"]
        //For empty fields there will be no "Select All", so we need to check
        sleep(3)
        if selectAll.waitForExistence(timeout: 0.5), selectAll.exists {
            selectAll.tap()
            typeText(String(XCUIKeyboardKey.delete.rawValue))
        }
        sleep(3)
        if let newVal = newText { typeText(newVal) }
    }
}
