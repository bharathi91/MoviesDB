//
//  Movie.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation
import UIKit.UIImage
import Combine

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let poster: String?
    let voteAverage: Float
    let releaseDate: String?
}
extension Movie: Codable {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Movie.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"

    }
}
//extension Movie: Hashable {
//    static func == (lhs: Movie, rhs: Movie) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

