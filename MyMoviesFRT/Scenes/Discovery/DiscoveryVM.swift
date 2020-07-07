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
    var networkIsReachable: BehaviorSubject<Bool> { get }
    var screenState: BehaviorSubject<DiscoveryScreenState> { get }
    var movies: PublishSubject<[Movie]> { get }
    func showMovieDetailScene(model: Movie)
    
}

class DiscoveryVM: MVVMViewModel {
    
    let router: MVVMRouter
    let tmdbManager: TMDBManagerProtocol
    let networkManager: NetworkManagerProtocol
    
    var networkIsReachable: BehaviorSubject<Bool> = BehaviorSubject<Bool>.init(value: false)
    var screenState: BehaviorSubject<DiscoveryScreenState> = BehaviorSubject<DiscoveryScreenState>.init(value: .loading)
    var movies: PublishSubject<[Movie]> = PublishSubject<[Movie]>()

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
            self.networkIsReachable.onNext(value)
        }).disposed(by: disposeBag)
    }
}

extension DiscoveryVM: DiscoveryVMProtocol {
    func showMovieDetailScene(model: Movie) {
        router.enqueueRoute(with: DiscoveryRouter.RouteType.showMovie(movie: model), animated: true, completion: nil)
    }
    
    func fetchDiscovery() {
        tmdbManager.getDiscovery(page: 1, sortBy: .popularityAsc).subscribe(onNext: { (discovery) in
            print(discovery)
            self.movies.onNext(discovery.results)
            self.screenState.onNext(.discoveryMovies)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disposeBag)
    }
}

enum DiscoveryScreenState {
    case discoveryMovies
    case favouriteMovies
    case loading
    case loadingMore
}
