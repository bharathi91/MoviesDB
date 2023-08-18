//
//  MoviesListUseCaseImplTest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class MoviesListUseCaseImplTest: XCTestCase {
    func testMoviesListUseCaseImpl() async {
        let moviesListViewModalImpl = MoviesListViewModalImpl(useCase: MoviesListUseCaseImpl(repository: MoviesListRepositoryImpl(service: MoviesListServiceImpl(networkManager: NetworkManager()))))
        let movies = try await moviesListViewModalImpl.getMovieList(searchString: "James")
        XCTAssertNotNil(movies)
        XCTAssertFalse((moviesListViewModalImpl.getcellData(index: 1) != nil))
        XCTAssertFalse((moviesListViewModalImpl.getCellCount() != 0))
        XCTAssertFalse((moviesListViewModalImpl.getListData().count != 0))
        XCTAssertFalse((moviesListViewModalImpl.updateSearchResults(searchString: "") == false))
        XCTAssertFalse((moviesListViewModalImpl.updateSearchResults(searchString: "Joker") == true))

    }
}

