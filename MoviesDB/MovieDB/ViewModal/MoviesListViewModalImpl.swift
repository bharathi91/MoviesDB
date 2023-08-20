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
                if self?.filteredData?.count ?? 0 > 0 {
                    self?.reloadTable.value = true
                } else {
                    self?.reloadTable.value = false
                }
                
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
    
    func updateSearchResults(searchString: String) -> Bool {
        let listResults = listData
        if searchString.isEmpty {
           filteredData = listData
            return true
        }
        else {
                let filteredList = listResults?.filter({ movie in
                return movie.title.lowercased().contains(searchString.lowercased())
            })
           filteredData = filteredList
        }
        if (filteredData != nil) && (filteredData?.count ?? 0) > 0 {
            self.reloadTable.value = true

        } else {
            self.reloadTable.value = false
        }
        return false
    }
}


