//
//  MoviesListRepositoryImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 17/08/23.
//

import Foundation
class MoviesListRepositoryImpl: IMoviesListRepository {
    func getMovieDetails(searchString: String,index: String, completion: @escaping (Result<MoviesDetailModel, Error>) -> Void) {
        return service.getMovieDetail(searchString: searchString, index: index, completion: completion)
    }
    
    func getMovieList(searchString: String, completion: @escaping (Result<MoviesListModel, Error>) -> Void) {
        return service.getMovieList(searchString: searchString, completion: completion)

    }
    private let service: IMoviesListService
    
    init(service: IMoviesListService) {
        self.service = service
    }
}
