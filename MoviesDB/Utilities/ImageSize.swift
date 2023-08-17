//
//  ImageSize.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//
//

import Foundation

enum ImageSize {
    case small
    case original
    var url: URL {
        switch self {
        case .small: return Configuration.smallImageUrl
        case .original: return Configuration.originalImageUrl
        }
    }
}
