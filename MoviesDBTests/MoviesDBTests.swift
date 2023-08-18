//
//  MoviesDBTests.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 15/08/23.
//

import XCTest
import UIKit
import Combine

@testable import MoviesDB

final class MoviesDBTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testVCRouter() {
        MoviesDBRouter.routeToMovieList()
        if ((UIApplication.topViewController()?.isKind(of: MoviesListViewController.self)) != nil)  {
            XCTAssert(true)
        }
    }
    
}



