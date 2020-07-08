//
//  TMDBManager.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import RxSwift

protocol TMDBManagerProtocol: class {
    init(backendManager: TMDBManagerBMProtocol)
    func getDiscovery(page: Int, filter: MovieFilter) -> Observable<Discovery>
}

class TMDBManager: TMDBManagerProtocol {
    var backendManager: TMDBManagerBMProtocol
    let disposeBag = DisposeBag()
    
    required init(backendManager: TMDBManagerBMProtocol) {
        self.backendManager = backendManager
    }
}

extension TMDBManager {
    func getDiscovery(page: Int, filter: MovieFilter) -> Observable<Discovery> {
        return backendManager.getDiscovery(page: page, filter: filter)
    }
}
