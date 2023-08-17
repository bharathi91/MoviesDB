//
//  MoviesListViewModalImpl.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation
class MoviesListViewModalImpl: IMoviesListViewModel {

    private let useCase: IMoviesListUseCase
    var listData: [Movie]?
    var filteredData: [Movie]?
    
    var input: MoviesListViewModelInput { return self }
    var output: MoviesListViewModelOutput {return self }
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    
    init(useCase: IMoviesListUseCase) {
        self.useCase = useCase
    }
    
    func getMovieList(searchString:String) {
        useCase.getList( searchString: searchString, completion: { [weak self] result in
            switch result {
            case .success(let list):
                self?.listData = list
                self?.filteredData = list
                self?.reloadTable.value = true
            case .failure( _):
                DispatchQueue.main.async {
                    
                }
            }
        })
    }
    
    func getCellCount() -> Int {
        return self.filteredData?.count ?? 0
    }
    
    func getcellData(index: Int) -> Movie? {
        if let data = filteredData {
            return data[index]
        }
        return nil
    }
    
    func getListData() -> [Movie] {
        if let data = listData {
            return data
        }
        return []
    }
    
    func updateSearchResults(searchString: String) {
        let listResults = listData
        if searchString.isEmpty {
           filteredData = listData
        }
        else {
                let filteredList = listResults?.filter({ movie in
                return movie.title.lowercased().contains(searchString.lowercased())
            })
           filteredData = filteredList
        }
        self.reloadTable.value = true
    }
}
protocol IMoviesListUseCase {
    func getList(searchString: String,completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol IMoviesListViewModel: MoviesListViewModelOutput, MoviesListViewModelInput {
    var input: MoviesListViewModelInput { get }
    var output: MoviesListViewModelOutput { get }
}

protocol MoviesListViewModelInput {
    func getMovieList(searchString:String)
    func getCellCount() -> Int
    func getcellData(index: Int) -> Movie?
    func updateSearchResults(searchString: String)
    func getListData() -> [Movie]
}
protocol MoviesListViewModelOutput {
    var reloadTable: Dynamic<Bool> { get }
}

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ val: T) {
        value = val
    }
}
