//
//  MovieDetail.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation
import UIKit

public class MovieDetail {
     let networkManager: INetworkManager
     let movieData: Movie
     let MovieListData: [Movie]
    
    init(networkManager: INetworkManager, movieData: Movie, movieListData: [Movie]) {
        self.networkManager = networkManager
        self.movieData = movieData
        self.MovieListData = movieListData
    }
    
    public func createMovieDetailViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let nxtVC = storyboard.instantiateViewController(withIdentifier: "MoviesDetailViewController")
     
        if let viewController = nxtVC as? MoviesDetailViewController {
            viewController.viewModel = createMovieDetailViewModel()
//            viewController.viewModel?.outputDelegate = viewController
            return viewController
        }
        return nil
    }
    
     func createMovieDetailViewModel() -> MoviesDetailViewModalImpl {
        let viewModel = MoviesDetailViewModalImpl(movieData: movieData)
        return viewModel
    }

}
