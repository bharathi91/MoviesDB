//
//  Configuration.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation

struct Configuration {
    static let originalImageUrl = URL(string: "https://image.tmdb.org/t/p/original")!
    static let smallImageUrl = URL(string: "https://image.tmdb.org/t/p/w154")!
    static let baseUrl = "https://api.themoviedb.org/3/search/movie?query="
    static let api_key = "&api_key=c8cf4b259fb6aed1e8562a005b7f6d8c&language=en"
}
