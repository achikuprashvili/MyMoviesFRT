//
//  TMDBManagerBM.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import RxSwift

protocol TMDBManagerBMProtocol: class {
    func getDiscovery(page: Int, sortBy: MovieSortOptions) -> Observable<Discovery>
}

extension BackendManager: TMDBManagerBMProtocol {
    func getDiscovery(page: Int, sortBy: MovieSortOptions) -> Observable<Discovery> {
        return decodableRequest(TMDBRequestRouter.getDiscovery(page: page, sortBy: sortBy))
    }
}
