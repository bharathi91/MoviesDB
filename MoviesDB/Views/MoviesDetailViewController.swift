//
//  MoviesDetailViewController.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    var viewModel: MoviesDetailViewModalImpl?
   // @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var header: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var overview: UILabel!
    var modal: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
    func updateUI() {
        self.title = modal?.title
        header.text = modal?.title
        subtitle.text = modal?.title
        rating.text = "\(modal?.voteAverage)"
        overview.text = modal?.overview
        poster.loadRemoteImageFrom(urlString: "\(Configuration.originalImageUrl)\(modal?.poster ?? "")")

    }

}
