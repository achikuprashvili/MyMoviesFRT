//
//  RequestRouter.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/6/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestRouter: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
}

extension RequestRouter {
    
    func asURLRequest() throws -> URLRequest {
        let url = try (Constants.baseURL + path).asURL()
        var urlRequest = try URLEncoding.default.encode(URLRequest(url: url), with: parameters)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
