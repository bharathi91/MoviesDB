//
//  MoviesList.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation
import UIKit

public class MoviesList {
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    public func createMovieListViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let nxtVC = storyboard.instantiateViewController(withIdentifier: "MoviesListViewController")
     
        if let viewController = nxtVC as? MoviesListViewController {
            viewController.viewModel = createMovieListViewModel()
            return viewController
        }
        return nil
    }
    
     private func createMovieListViewModel() -> MoviesListViewModalImpl {
         let viewModel = MoviesListViewModalImpl(useCase: createMovieListUseCase())
         return viewModel
     }
    private func createMovieListUseCase() -> IMoviesListUseCase {
        let useCase = MoviesListUseCaseImpl(repository: createMovieListRepository())
        return useCase
    }
    private func createMovieListRepository() -> IMoviesListRepository {
        let repository = MoviesListRepositoryImpl(service: createMovieListService())
        return repository
    }
    private func createMovieListService() -> IMoviesListService {
        let service = MoviesListServiceImpl(networkManager: self.networkManager)
        return service
    }
}

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
protocol IMoviesListRepository {
    func getMovieList(searchString: String,completion: @escaping (Result<MoviesListModel, Error>) -> Void)
    func getMovieDetails(searchString: String,index: String, completion: @escaping (Result<MoviesDetailModel, Error>) -> Void)
}
struct MoviesDetailModel: Decodable {
    let id: Int?
}
struct MoviesListModel: Decodable {
    let count: Double?
    let next: String?
    let previous: String?
    let results: [Movie]?
}
protocol IMoviesListService {
    func getMovieList(searchString: String,completion: @escaping (Result<MoviesListModel, Error>) -> Void)
    func getMovieDetail(searchString: String,index: String, completion: @escaping (Result<MoviesDetailModel, Error>) -> Void)
}


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

enum APIEndPointConstants {
    static let listEndpoint = ""
    
}
class MoviesListUseCaseImpl: IMoviesListUseCase {
    func getList(searchString: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        return repository.getMovieList(searchString: searchString) { (result: Result<MoviesListModel, Error>) in
            switch result {
            case .success(let data):
                guard let objs = data.results else {return}
                self.getMovieDetails(data: objs, completion: completion)
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
    
    
    private let repository: IMoviesListRepository
    
    init(repository: IMoviesListRepository) {
        self.repository = repository
    }
    
    func getMovieDetails(data: [Movie], completion: @escaping (Result<[Movie], Error>) -> Void) {
        var movieIndex = 1
        var movieData: [Movie] = []
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "any-label-name")
        let dispatchSemaphore = DispatchSemaphore(value: 0)
        dispatchQueue.async {
            for var obj in data {
                dispatchGroup.enter()
                completion(.success(data))
            }
        }
    }
}
