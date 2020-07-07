//
//  MovieMO.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

extension FavouriteMovieMO {
    func updateDate(from movie: Movie) {
        id = Int64(movie.id)
        originalTitle = movie.originalTitle
        title = movie.title
        overview = movie.overview
        releaseDate = movie.releaseDate
        posterPath = movie.posterPath
        voteAverage = movie.voteAverage
    }
}
