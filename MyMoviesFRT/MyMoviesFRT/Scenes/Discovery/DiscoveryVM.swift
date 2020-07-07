//
//  DiscoveryVM.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import RxSwift

// MARK:- Protocol

protocol DiscoveryVMProtocol {
    func fetchDiscovery()
}

class DiscoveryVM: MVVMViewModel {
    
    let router: MVVMRouter
    let tmdbManager: TMDBManagerProtocol
    let networkManager: NetworkManagerProtocol
    let disposeBag = DisposeBag()
    
    //==============================================================================
    
    init(with router: MVVMRouter, tmdbManager: TMDBManagerProtocol, networkManager: NetworkManagerProtocol) {
        self.router = router
        self.tmdbManager = tmdbManager
        self.networkManager = networkManager
        initObservables()
        fetchDiscovery()
    }
    
    //==============================================================================
    
    private func initObservables() {
        networkManager.isReachable.subscribe(onNext: { (value) in
            
        }).disposed(by: disposeBag)
    }
}

extension DiscoveryVM: DiscoveryVMProtocol {
    func fetchDiscovery() {
        tmdbManager.getDiscovery(page: 1, sortBy: .popularityAsc).subscribe(onNext: { (discovery) in
            print(discovery)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disposeBag)
    }
}
