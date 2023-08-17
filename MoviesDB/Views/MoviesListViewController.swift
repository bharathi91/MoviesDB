//
//  MoviesListViewController.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import UIKit

class MoviesListViewController: UIViewController {
    var viewModel: MoviesListViewModalImpl?
   
    @IBOutlet private var loadingView: UIView!
    @IBOutlet var tableView: UITableView!
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        searchController.searchBar.delegate = self
        return searchController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        viewModel?.input.getMovieList(searchString: "james")
        self.configureView()
        self.setupObserver()
    }
    
    private func configureView() {
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.searchController = self.searchController
        searchController.isActive = true
    }
    
    private func setupObserver() {
        /// reload CollectionView
        ///
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: MovieTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel?.output.reloadTable.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                print("completed")
            }
        }
    }

}

extension MoviesListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.input.getCellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withClass: MovieTableViewCell.self) else {
            assertionFailure("Failed to dequeue \(MovieTableViewCell.self)!")
            return UITableViewCell()
        }
        cell.bind(to: viewModel?.input.getcellData(index: indexPath.row) ?? Movie(id: 0, title: "test", overview: "test", poster: "Test", voteAverage: 10.0, releaseDate: "Test"))

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        details.modal = viewModel?.input.getcellData(index: indexPath.row)
        self.navigationController?.pushViewController(details, animated: true)
    }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            searchController.searchBar.resignFirstResponder()
        }

}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // search.send(searchText)
        viewModel?.updateSearchResults(searchString: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.updateSearchResults(searchString: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.input.getMovieList(searchString: searchBar.text ?? "Joker")

    }
}
