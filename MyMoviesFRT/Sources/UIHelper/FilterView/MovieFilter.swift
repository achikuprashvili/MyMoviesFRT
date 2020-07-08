//
//  DiscoveryFilter.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

class MovieFilter {
    var sortBy: MovieSortOptions = .popularityDesc
    var minRating: Double = 0
    var maxRating: Double = 10
}

enum MovieSortOptions: String, CaseIterable {
    case popularityAsc = "popularity.asc"
    case popularityDesc = "popularity.desc"
    case ratingAsc = "vote_average.asc"
    case ratingDesc = "vote_average.desc"
    case releaseDateAsc = "release_date.asc"
    case releaseDateDesc = "release_date.desc"
    
    var title: String {
        switch self {
        case .popularityAsc:
            return "Popularity Asc."
        case .popularityDesc:
            return "Popularity Desc."
        case .ratingAsc:
            return "Rating Asc."
        case .ratingDesc:
            return "Rating Desc."
        case .releaseDateAsc:
            return "Release Date Asc."
        case .releaseDateDesc:
            return "Release Date Desc."
        }
    }
}
