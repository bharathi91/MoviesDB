//
//  MovieModaltest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class MovieModalTest: XCTestCase {
    func testMovieModal() {
        do {
              if let bundlePath = Bundle.main.path(forResource: "Movies", ofType: "json"),
              let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                 if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                    print("JSON: \(json)")
                     if let array = json["results"] as? NSArray {
                         do {
                             let job = try Movie(dictionary: array[0] as! [String : Any])
                             print(job.title)
                             print(job.poster)
                             print(job.releaseDate)
                                XCTAssertTrue(job != nil)
                         } catch {
                             print(error)
                         }
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
