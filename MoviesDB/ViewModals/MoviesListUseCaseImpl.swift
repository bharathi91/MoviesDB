//
//  MoviesListUseCaseImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 17/08/23.
//

import Foundation
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
