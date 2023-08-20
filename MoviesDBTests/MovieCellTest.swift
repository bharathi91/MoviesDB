//
//  MovieCelltest.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
import XCTest
@testable import MoviesDB
final class MovieCellTest: XCTestCase {
    func testMovieTableCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MoviesListViewController") as! MoviesListViewController
        controller.loadViewIfNeeded()
        controller.tableView.awakeFromNib()
        //let cell = controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MovieTableViewCell
        let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieTableViewCell

        let indexPath = NSIndexPath(row: 0, section: 0)
        cell?.bind(to: Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18"))
        cell?.showImage(image: cell?.poster.image)
        XCTAssertTrue(cell?.title != nil)
        //controller.searchBar.text = "Test"
        
        XCTAssertFalse(controller.tableView.registerNib(cellClass: MovieTableViewCell.self) == nil)
        XCTAssertFalse(controller.tableView.registerClass(cellClass: MovieTableViewCell.self) == nil)
    //        let cell2 = controller.tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: IndexPath(row: 0, section: 0)) as? MovieTableViewCell
    //        XCTAssertTrue(cell2 != nil)
    }

}
