//
//  MovieDetailstest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class MovieDetailsTest: XCTestCase {
    func testMovieDetail() {
        let movieDetail = MovieDetail(networkManager: NetworkManager(), movieData: Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"), movieListData: [Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"),Movie(id: 2, title: "Test2", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18")])
        let vc = movieDetail.createMovieDetailViewController()
        XCTAssertTrue(vc != nil)
         
    }
}

