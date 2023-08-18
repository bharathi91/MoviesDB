//
//  MoviesListRepositoryImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 17/08/23.
//

import Foundation
class MoviesListRepositoryImpl: IMoviesListRepository {

    private let service: IMoviesListService
    
    init(service: IMoviesListService) {
        self.service = service
    }
    
    func getMovieList(searchString: String, completion: @escaping (Result<MoviesListModel, Error>) -> Void) {
        return service.getMovieList(searchString: searchString, completion: completion)

    }
}
