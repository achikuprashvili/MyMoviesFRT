//
//  TMDBRequestRouter.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import Alamofire

enum TMDBRequestRouter: RequestRouter {
    
    case getDiscovery(page: Int, filter: MovieFilter)
    
    var method: HTTPMethod {
        switch self {
        case .getDiscovery:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDiscovery:
            return "/discover/movie"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getDiscovery(let page, let filter):
            return ["api_key": Constants.tmdbApiKey, "page": page, "sort_by": filter.sortBy.rawValue, "vote_average.gte": filter.minRating, "vote_average.lte": filter.maxRating]
        }
    }
}
