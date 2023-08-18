//
//  ListModal.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 18/08/23.
//

import Foundation

struct MoviesListModel: Decodable {
    let count: Double?
    let next: String?
    let previous: String?
    let results: [Movie]?
}


