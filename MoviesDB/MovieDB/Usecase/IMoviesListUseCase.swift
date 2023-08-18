//
//  IMoviesUseCase.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation
protocol IMoviesListUseCase {
    func getList(searchString: String,completion: @escaping (Result<[Movie], Error>) -> Void)
}
