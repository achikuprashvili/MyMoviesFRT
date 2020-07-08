//
//  MovieVM.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import RxSwift
// MARK:- Protocol

protocol MovieVMProtocol {
    func getTitle() -> String
    func getOriginalTitle() -> String
    func getRating() -> String
    func addToFavourite()
    func removeMovieFromFavourite()
    func getReleaseDate() -> String
    func getPosterUrl() -> URL?
    func getOverView() -> String
    var isMovieFavourite: BehaviorSubject<Bool> { get }
}

class MovieVM: MVVMViewModel {
    
    let router: MVVMRouter
    let movie: Movie
    let dataManager: DataManagerProtocol
    var isMovieFavourite: BehaviorSubject<Bool> = BehaviorSubject<Bool>.init(value: false)
    
    
    //==============================================================================
    
    init(with router: MVVMRouter, movie: Movie, dataManager: DataManagerProtocol) {
        self.router = router
        self.movie = movie
        self.dataManager = dataManager
        isMovieFavourite.onNext(dataManager.isFavouriteMovie(movieId: movie.id))
    }
    
    //==============================================================================
}

extension MovieVM: MovieVMProtocol {
    func removeMovieFromFavourite() {
        dataManager.deleteMovieFromFavourite(with: movie.id)
        isMovieFavourite.onNext(false)
    }
    
    func getTitle() -> String {
        return movie.title
    }
    
    func getOriginalTitle() -> String {
        return movie.originalTitle
    }
    
    func getRating() -> String {
        return "\(movie.voteAverage)"
    }
    
    func addToFavourite() {
        dataManager.saveMovieAs(favourite: movie)
        isMovieFavourite.onNext(true)
    }
    
    func getReleaseDate() -> String {
        return movie.releaseDate
    }
    
    func getPosterUrl() -> URL? {
        return URL(string: Constants.imageBaseUrl + "/w500" + (movie.posterPath ?? " "))
    }
    
    func getOverView() -> String {
        return movie.overview
    }
    
    
}
