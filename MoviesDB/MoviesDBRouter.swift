//
//  MoviesDBRouter.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation
import UIKit

class MoviesDBRouter: NSObject {
    
    static let networkManager = NetworkManager.initObject
    
    static func routeToMovieList() -> UIViewController? {
        let module = MoviesList(networkManager: networkManager)
        if let controller = module.createMovieListViewController() {
            let nvc: UINavigationController = UINavigationController(rootViewController: controller)
            return nvc
        }
        return nil
    }
    
    static func routeToMovieDetails(movieData: Movie, MovieListData: [Movie]) -> UIViewController? {
        let module = MovieDetail(networkManager: networkManager, movieData: movieData, movieListData: MovieListData)
        if let controller = module.createMovieDetailViewController() {
            return controller
        }
        return nil
    }
}
