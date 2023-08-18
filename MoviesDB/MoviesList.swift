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




