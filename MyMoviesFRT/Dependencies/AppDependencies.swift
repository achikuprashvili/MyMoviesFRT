//
//  AppDependencies.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

struct AppDependencies {
    var tmdbManager: TMDBManagerProtocol
    var networkManager: NetworkManagerProtocol
    var dataManager: DataManagerProtocol
    
    init(backendManager: BackendManager) {
        self.tmdbManager = TMDBManager(backendManager: backendManager)
        self.networkManager = NetworkManager()
        self.dataManager = DataManager()
    }
}
