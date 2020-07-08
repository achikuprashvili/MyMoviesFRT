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
    func showMovieDetailScene(model: Movie)
    func showFavoriteMovies()
    func showDiscoveryMovies()
    func setFilter(filter: MovieFilter)
    func loadMore()
    func fetchFavouriteMovies()
    
    var networkIsReachable: BehaviorSubject<Bool> { get }
    var movies: PublishSubject<[Movie]> { get }
    var showActivityIndicator: BehaviorSubject<Bool> { get }
    var showEmptyScreenPlaceholder: BehaviorSubject<Bool> { get }
    var showNoNetworkPlaceholder: BehaviorSubject<Bool> { get }
    var movieFilter: MovieFilter { get }
    var handleError: PublishSubject<Error> { get }
}

class DiscoveryVM: MVVMViewModel {
    
    let router: MVVMRouter
    let tmdbManager: TMDBManagerProtocol
    let networkManager: NetworkManagerProtocol
    let dataManager: DataManagerProtocol
    var movieFilter: MovieFilter = MovieFilter()
    var networkIsReachable: BehaviorSubject<Bool> = BehaviorSubject<Bool>.init(value: false)
    var showActivityIndicator: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var showEmptyScreenPlaceholder: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var showNoNetworkPlaceholder: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var movies: PublishSubject<[Movie]> = PublishSubject<[Movie]>()
    var handleError: PublishSubject<Error> = PublishSubject<Error>()
    var favouriteMovies: [Movie] = []
    
    private var isLoading: Bool = false
    private var page: Int = 1
    private var discoveryMovies: [Movie] = []
    private var selectedSegment: Int = 0

    let disposeBag = DisposeBag()

    
    //==============================================================================
    
    init(with router: MVVMRouter, tmdbManager: TMDBManagerProtocol, networkManager: NetworkManagerProtocol, dataManager: DataManagerProtocol) {
        self.router = router
        self.tmdbManager = tmdbManager
        self.networkManager = networkManager
        self.dataManager = dataManager
        initObservables()
        fetchDiscovery()
    }
    
    //==============================================================================
    
    private func initObservables() {
        networkManager.isReachable.subscribe(onNext: { (value) in
            self.showNoNetworkPlaceholder.onNext(!value)
        }).disposed(by: disposeBag)
    }
}

extension DiscoveryVM: DiscoveryVMProtocol {
    func setFilter(filter: MovieFilter) {
        self.movieFilter = filter
    }
    
    func showFavoriteMovies() {
        selectedSegment = 1
        self.movies.onNext(favouriteMovies)
        self.showEmptyScreenPlaceholder.onNext(favouriteMovies.count == 0)
    }
    
    func fetchFavouriteMovies() {
        self.favouriteMovies = dataManager.getAllFavouriteMovies()
        if selectedSegment == 1 {
            showFavoriteMovies()
        }
    }
    
    func showDiscoveryMovies() {
        selectedSegment = 0
        fetchDiscovery()
    }
    
    func showMovieDetailScene(model: Movie) {
        router.enqueueRoute(with: DiscoveryRouter.RouteType.showMovie(movie: model), animated: true, completion: nil)
    }
    
    func fetchDiscovery() {
        if isLoading {
            return
        }
        discoveryMovies = []
        getDiscovery(page: 1, filter: movieFilter)
    }
    
    func loadMore() {
        if isLoading {
            return
        }
        getDiscovery(page: page + 1, filter: movieFilter)
    }
    
    func getDiscovery(page: Int, filter: MovieFilter) {
        isLoading = true
        showActivityIndicator.onNext(isLoading)
        tmdbManager.getDiscovery(page: page, filter: filter).subscribe(onNext: { (discovery) in
            self.isLoading = false
            self.discoveryMovies.append(contentsOf: discovery.results)
            self.movies.onNext(self.discoveryMovies)
            self.page = discovery.page
            self.showEmptyScreenPlaceholder.onNext(self.discoveryMovies.count == 0)
            self.showActivityIndicator.onNext(self.isLoading)
        }, onError: { (error) in
            self.isLoading = false
            self.handleError.onNext(error)
            self.showEmptyScreenPlaceholder.onNext(self.discoveryMovies.count == 0)
            self.showActivityIndicator.onNext(self.isLoading)
        }).disposed(by: disposeBag)
    }
}
