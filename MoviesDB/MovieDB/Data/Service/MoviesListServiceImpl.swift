//
//  MoviesListServiceImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 17/08/23.
//

import Foundation
class MoviesListServiceImpl: IMoviesListService {
    
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovieList(searchString: String,completion: @escaping (Result<MoviesListModel, Error>) -> Void) {
        let request = NetworkRequest(path: "", method: .get)
        self.networkManager.request(searchString: searchString, request: request, completion: completion)
    }
}
