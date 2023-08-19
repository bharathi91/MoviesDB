//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import UIKit
import Combine

class MovieTableViewCell: UITableViewCell, NibProvidable, ReusableView {

    @IBOutlet var title: UILabel!
    @IBOutlet private var subtitle: UILabel!
    @IBOutlet private var rating: UILabel!
    @IBOutlet var poster: UIImageView!
    private var cancellable: AnyCancellable?

    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }

    func bind(to viewModel: Movie) {
        cancelImageLoading()
        title.text = viewModel.title
        title.accessibilityIdentifier = viewModel.poster
        subtitle.text = viewModel.releaseDate
        rating.text = "\(viewModel.voteAverage)"
        poster.loadRemoteImageFrom(urlString: "\(Configuration.smallImageUrl)\(viewModel.poster ?? "")")
    }

     func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.poster,
        duration: 0.3,
        options: [.curveEaseOut, .transitionCrossDissolve],
        animations: {
            self.poster.image = image
        })
    }

    private func cancelImageLoading() {
        poster.image = nil
        cancellable?.cancel()
    }

}
