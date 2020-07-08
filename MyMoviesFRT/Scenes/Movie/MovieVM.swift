//
//  MovieVM.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

// MARK:- Protocol

protocol MovieVMProtocol {
    
}

class MovieVM: MVVMViewModel {
    
    let router: MVVMRouter
    let movie: Movie
    let dataManager: DataManagerProtocol
    
    //==============================================================================
    
    init(with router: MVVMRouter, movie: Movie, dataManager: DataManagerProtocol) {
        self.router = router
        self.movie = movie
        self.dataManager = dataManager
        dataManager.saveMovieAs(favourite: movie)
    }
    
    //==============================================================================
}

extension MovieVM: MovieVMProtocol {
    
}
