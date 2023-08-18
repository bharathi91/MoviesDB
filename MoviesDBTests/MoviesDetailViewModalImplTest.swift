//
//  MoviesDetailViewModalImpltest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class MoviesDetailViewModalImplTest: XCTestCase {
    func testMoviesDetailViewModalImpl() {
        let moviedetailImpl = MoviesDetailViewModalImpl(movieData: Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"))
        XCTAssertTrue(moviedetailImpl.movieData != nil)
        
        XCTAssertTrue(moviedetailImpl.input != nil)
        XCTAssertTrue(moviedetailImpl.output != nil)
        
    }

}
