//
//  IMovie.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
protocol IMoviesListViewModel: MoviesListViewModelOutput, MoviesListViewModelInput {
    var input: MoviesListViewModelInput { get }
    var output: MoviesListViewModelOutput { get }
}

protocol MoviesListViewModelInput {
    func getMovieList(searchString:String)
    func getCellCount() -> Int
    func getcellData(index: Int) -> Movie?
    func updateSearchResults(searchString: String) -> Bool
    func getListData() -> [Movie]
}
protocol MoviesListViewModelOutput {
    var reloadTable: Dynamic<Bool> { get }
}
