//
//  Constants.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/6/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
struct Constants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseUrl = "https://image.tmdb.org/t/p"
    static let tmdbApiKey = "5977d0e360abdd73aaaca1e6f492c58f"
    static let tmdbApiToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1OTc3ZDBlMzYwYWJkZDczYWFhY2ExZTZmNDkyYzU4ZiIsInN1YiI6IjVmMDM5OTI2ZDJiMjA5MDAzYWE0Y2MxZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mqDXi7_QAMgWsRkDybJW3PQKXfN4wtmy2mR6mhXXcww"
    static let activityIndicatorTag = 100
    static let noNetworkConnectionPlaceholderTag = 101
    static let noMoviesPlaceholderTag = 102
}
