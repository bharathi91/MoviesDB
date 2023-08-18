//
//  Movies.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation

struct Movies {
    let items: [Movie]
}

extension Movies: Decodable {

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
