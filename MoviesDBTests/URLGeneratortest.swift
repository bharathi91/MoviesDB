//
//  URLGeneratortest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class URLGeneratortest: XCTestCase {
    func testMovieDetailsList() {
      let URLRequestGenerator = URLRequestGenerator()
        var request = NetworkRequest(path: "", method: .get)
        do {
            let urlrequest = try URLRequestGenerator.createURLRequest(serachString: "Joker", using:request)
            XCTAssertTrue(((urlrequest.url?.absoluteString.contains("Joker")) != nil))
        }
        catch {
            // Couldn't create audio player object, log the error
            print("failed")
        }
        
    }
}

