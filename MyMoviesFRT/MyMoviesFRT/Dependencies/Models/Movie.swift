//
//  Movie.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

class Movie: Codable {
    var title: String
    var originalTitle: String
    var overview: String
    var posterPath: String
    var releaseDate: String
    var voteAverage: Double
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case title, id, overview
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
