//
//  MoviesDetailViewControllerTest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class MoviesDetailViewControllerTest: XCTestCase {
    func testMovieDetailsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviedetailVC = storyboard.instantiateViewController(identifier: "MoviesDetailViewController") as! MoviesDetailViewController
        moviedetailVC.viewModel = MoviesDetailViewModalImpl(movieData: Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18"))
        moviedetailVC.loadViewIfNeeded()
        moviedetailVC.modal = Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18")
        moviedetailVC.viewWillAppear(true)

        XCTAssertTrue(moviedetailVC.header.text != nil)
        XCTAssertTrue(moviedetailVC.subtitle.text != nil)
        XCTAssertTrue(moviedetailVC.rating.text != nil)
        XCTAssertTrue(moviedetailVC.overview.text != nil)
        XCTAssertTrue(moviedetailVC.poster.image == nil)
    }

    func testMoviesDetailViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MoviesDetailViewController") as! MoviesDetailViewController
        controller.modal = Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18")
        controller.loadViewIfNeeded()
        XCTAssertTrue(controller.subtitle.text != nil)
    }

    func testMoviesDetailViewModalImpl2() {
        let moviesDetailViewModalImpl = MoviesDetailViewModalImpl(movieData:Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18") )
        
        XCTAssertTrue(moviesDetailViewModalImpl != nil)
    }
}

