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

enum MovieSortOptions: String {
    case popularityAsc = "popularity.asc"
    case popularityDesc = "popularity.desc"
    case ratingAsc = "vote_average.asc"
    case ratingDesc = "vote_average.desc"
    case releaseDateAsc = "release_date.asc"
    case releaseDateDesc = "release_date.desc"
}
