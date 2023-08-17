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
        var request = NetworkRequest(path: APIEndPointConstants.listEndpoint, method: .get)
        //request.headerParamaters =  ["accept": "application/json","Authorization": "Bearer c8cf4b259fb6aed1e8562a005b7f6d8c"]
        self.networkManager.request(searchString: searchString, request: request, completion: completion)
    }
    
    func getMovieDetail(searchString: String,index: String, completion: @escaping (Result<MoviesDetailModel, Error>) -> Void) {
        let request = NetworkRequest(path: index, method: .get)
        self.networkManager.request(searchString: searchString, request: request, completion: completion)
    }
}
