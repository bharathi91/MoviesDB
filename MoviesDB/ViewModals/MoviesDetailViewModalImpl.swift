//
//  MoviesDetailViewModalImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation

class MoviesDetailViewModalImpl: IMoviesDetailViewModel {
    
   // var input: MovieDetailViewModelInput { get }
    let movieData: Movie
    var input: MovieDetailViewModelInput { return self }
    var output: MovieDetailViewModelOuptut {return self }
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    init(movieData: Movie) {
        self.movieData = movieData
    }
}
protocol IMoviesDetailViewModel: MovieDetailViewModelOuptut, MovieDetailViewModelInput {
    var input: MovieDetailViewModelInput { get }
    var output: MovieDetailViewModelOuptut { get }
}

protocol MovieDetailViewModelInput {
    //func getmovieSpecieDetail()
}
protocol MovieDetailViewModelOuptut {
    var reloadTable: Dynamic<Bool> { get }
}
