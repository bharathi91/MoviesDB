//
//  MoviesListUseCaseImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 17/08/23.
//

import Foundation
class MoviesListUseCaseImpl: IMoviesListUseCase {
    
    private let repository: IMoviesListRepository
    
    init(repository: IMoviesListRepository) {
        self.repository = repository
    }
    func getList(searchString: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        return repository.getMovieList(searchString: searchString) { (result: Result<MoviesListModel, Error>) in
            switch result {
            case .success(let data):
                guard let objs = data.results else {return}
                let dispatchQueue = DispatchQueue(label: "any-label-name")
                dispatchQueue.async {
                    completion(.success(objs))
                }
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
}
