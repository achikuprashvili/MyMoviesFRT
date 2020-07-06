//
//  DiscoverVM.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

// MARK:- Protocol

protocol DiscoverVMProtocol {
    
}

class DiscoverVM: MVVMViewModel {
    
    let router: MVVMRouter
    
    //==============================================================================
    
    init(with router: MVVMRouter) {
        self.router = router
    }
    
    //==============================================================================
}

extension DiscoverVM: DiscoverVMProtocol {
    
}
