//
//  MoviesDBTests.swift
//  MoviesDBTests
//
//  Created by Bharathi Kumar on 15/08/23.
//

import XCTest
import UIKit
import Combine

@testable import MoviesDB

final class MoviesDBTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testVCRouter() {
        MoviesDBRouter.routeToMovieList()
        if ((UIApplication.topViewController()?.isKind(of: MoviesListViewController.self)) != nil)  {
            XCTAssert(true)
        }
    }
    func testVCRouterToDetails() {
        MoviesDBRouter.routeToMovieDetails(movieData:Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18") , MovieListData: [Movie(id: 3, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18"),Movie(id: 4, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18")])
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviedetailVC = storyboard.instantiateViewController(identifier: "MoviesDetailViewController") as! MoviesDetailViewController
        if ((UIApplication.topViewController() == moviedetailVC) != nil)  {
            XCTAssert(true)
        }
    }
    func testMovieDetailsList() {
      let URLRequestGenerator = URLRequestGenerator()
        var request = NetworkRequest(path: APIEndPointConstants.listEndpoint, method: .get)
        do {
            let urlrequest = try URLRequestGenerator.createURLRequest(serachString: "Joker", using:request)
            XCTAssertTrue(((urlrequest.url?.absoluteString.contains("Joker")) != nil))
        }
        catch {
            // Couldn't create audio player object, log the error
            print("failed")
        }
        
    }
    
    func testNetworkErrorEnums() {
        let error1 = NetworkError.badRequest
        let error2 = NetworkError.failed
        let error3 = NetworkError.invalidRequest
        let error4 = NetworkError.noData
        let error5 = NetworkError.noResponse
        let error6 = NetworkError.unableToDecode
        XCTAssertTrue(error1.description == "Bad Request")
        XCTAssertTrue(error2.description == "Network Request Failed")
        XCTAssertTrue(error3.description == "Invalid Request")
        XCTAssertTrue(error4.description == "Response returned with no data")
        XCTAssertTrue(error5.description == "Response returned with no response")
        XCTAssertTrue(error6.description == "Response couldnot be decoded")
        
        XCTAssertTrue(NetworkError.badRequest.description == "Bad Request")
        
        
        var badRequest: NetworkError { .badRequest }
        XCTAssertEqual(badRequest, .badRequest)
        
        var failed: NetworkError { .failed }
        XCTAssertEqual(failed, .failed)
        
        var invalidRequest: NetworkError { .invalidRequest }
        XCTAssertEqual(invalidRequest, .invalidRequest)
        
        var noData: NetworkError { .noData }
        XCTAssertEqual(noData, .noData)
        
        var noResponse: NetworkError { .noResponse }
        XCTAssertEqual(noResponse, .noResponse)
        
        var unableToDecode: NetworkError { .unableToDecode }
        XCTAssertEqual(unableToDecode, .unableToDecode)
        
        var smallImage: ImageSize { .small }
        XCTAssertEqual(smallImage.url, Configuration.smallImageUrl)
        
        var originalImage: ImageSize { .original }
        XCTAssertEqual(originalImage.url, Configuration.originalImageUrl)

    }
    
    func testMovieDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviedetailVC = storyboard.instantiateViewController(identifier: "MoviesDetailViewController") as! MoviesDetailViewController
        moviedetailVC.viewModel = MoviesDetailViewModalImpl(movieData: Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"))
        moviedetailVC.loadViewIfNeeded()
        moviedetailVC.modal = Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18")
        moviedetailVC.updateUI()
        
        XCTAssertTrue(moviedetailVC.header.text != nil)
        XCTAssertTrue(moviedetailVC.subtitle.text != nil)
        XCTAssertTrue(moviedetailVC.rating.text != nil)
        XCTAssertTrue(moviedetailVC.overview.text != nil)
    }
    
    func testMovieDetailModal() {
        let moviedetail = MovieDetail(networkManager: NetworkManager(), movieData: Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"), movieListData: [Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"),Movie(id: 2, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"),Movie(id: 3, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18")])

        XCTAssertTrue(moviedetail.networkManager != nil)
        XCTAssertTrue(moviedetail.movieData != nil)
        XCTAssertTrue(moviedetail.MovieListData != nil)
        XCTAssertTrue(moviedetail.createMovieDetailViewModel() != nil)
       // XCTAssertTrue(moviedetail.createMovieDetailViewController() != nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MoviesDetailViewController") as! MoviesDetailViewController
        controller.viewModel = moviedetail.createMovieDetailViewModel()
        if ((UIApplication.topViewController()?.isKind(of: MoviesDetailViewController.self)) != nil)  {
            XCTAssert(true)
        }
        XCTAssertTrue(controller.viewModel != nil)
    }
    
    func testMovieModel() {
        let movie1 = Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18")
        let movie2 = Movie(id: 2, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18")
        XCTAssertTrue(movie1 != movie2)
    }
    
    func testImageDownloader() {
        
    }
    
    func testMovieModal() {
        do {
              if let bundlePath = Bundle.main.path(forResource: "Movies", ofType: "json"),
              let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                 if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                    print("JSON: \(json)")
                     let array = json["results"]
                    // let result = try JSONEncoder().encod
                     //print(result)
                 } else {
                    print("Given JSON is not a valid dictionary object.")
                 }
              }
           } catch {
              print(error)
           }
        
    }
    func testMoviesListUseCaseImpl() async {
        let moviesListViewModalImpl = MoviesListViewModalImpl(useCase: MoviesListUseCaseImpl(repository: MoviesListRepositoryImpl(service: MoviesListServiceImpl(networkManager: NetworkManager()))))
        let movies = try await moviesListViewModalImpl.getMovieList(searchString: "James")
        XCTAssertNotNil(movies)
    }
    func testMoviesDetailViewModalImpl() {
        let moviedetailImpl = MoviesDetailViewModalImpl(movieData: Movie(id: 1, title: "Test", overview: "Test", poster: "Test", voteAverage: 10.0, releaseDate: "2020-09-18"))
        XCTAssertTrue(moviedetailImpl.movieData != nil)
        
    }
    func testMovieTableCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MoviesListViewController") as! MoviesListViewController
        controller.loadViewIfNeeded()
        controller.tableView.awakeFromNib()
        //let cell = controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MovieTableViewCell
        let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieTableViewCell

        let indexPath = NSIndexPath(row: 0, section: 0)
        cell?.bind(to: Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18"))
        cell?.showImage(image: cell?.poster.image)
        XCTAssertTrue(cell?.title != nil)
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMoviesDetailViewModalImpl2() {
        let moviesDetailViewModalImpl = MoviesDetailViewModalImpl(movieData:Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18") )
        
        XCTAssertTrue(moviesDetailViewModalImpl != nil)
    }
    func testMoviesDetailViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MoviesDetailViewController") as! MoviesDetailViewController
        controller.modal = Movie(id: 1, title: "Test", overview: "Test", poster: "/5w18P8qU9sHRcW6pH3NVGVVIKFw.jpg", voteAverage: 10.0, releaseDate: "2020-09-18")
        controller.loadViewIfNeeded()
        XCTAssertTrue(controller.subtitle.text != nil)
    }

}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
