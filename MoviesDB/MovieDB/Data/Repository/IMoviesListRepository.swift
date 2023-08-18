//
//  UseCase.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
protocol IMoviesListRepository {
    func getMovieList(searchString: String,completion: @escaping (Result<MoviesListModel, Error>) -> Void)
}
