//
//  DiscoveryVC.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoveryVC: UIViewController, MVVMViewController {
    
    var viewModel: DiscoveryVMProtocol!
    let disposeBag = DisposeBag()
    lazy var filterView: FilterView = {
        let filterView = FilterView(frame: self.view.bounds)
        return filterView
    }()
    
    @IBOutlet weak var moviewSectionSegmentControll: UISegmentedControl!
    
    var collectionView: MoviesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchDiscovery()
        setupUI()
        initCollectionView()
        bindCollectionViewToViewModel()
        initObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavouriteMovies()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.AppColor.lightBlue
        addLogoToNavigationBar()
        
        let button = UIButton()
        button.setImage(UIImage(named: "filter")?.withTintColor(UIColor.AppColor.lightGreen), for: .normal)
        button
            .rx
            .tap
            .bind {
                self.addFilterView()
        }.disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        moviewSectionSegmentControll.setTitle("Discovery", forSegmentAt: 0)
        moviewSectionSegmentControll.setTitle("Favorites", forSegmentAt: 1)
        moviewSectionSegmentControll.selectedSegmentTintColor = UIColor.AppColor.lightGreen
        moviewSectionSegmentControll.tintColor = UIColor.white
        
        moviewSectionSegmentControll
            .rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { () in
                switch self.moviewSectionSegmentControll.selectedSegmentIndex {
                case 0:
                    self.viewModel.showDiscoveryMovies()
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                case 1:
                    self.viewModel.showFavoriteMovies()
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                default:
                    break
                }
            }
        ).disposed(by: disposeBag)
    }
    
    func initCollectionView() {
        collectionView = MoviesCollectionView(frame: view.bounds)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: moviewSectionSegmentControll.bottomAnchor, constant: 15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func bindCollectionViewToViewModel() {
        viewModel
            .movies
            .bind(to: collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.reuseIdentifier)) { index, movie, cell in
                let cellToUse = cell as! MovieCollectionViewCell
                cellToUse.config(movie: movie)
        }.disposed(by: disposeBag)
        
        collectionView
            .rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { (movie) in
                self.viewModel.showMovieDetailScene(model: movie)
            }, onError: nil, onCompleted: nil, onDisposed: nil
        ).disposed(by: disposeBag)
        
        collectionView
            .loadMore
            .bind { () in
                if self.moviewSectionSegmentControll.selectedSegmentIndex == 0 {
                    self.viewModel.loadMore()
                }
        }.disposed(by: disposeBag)
    }
    
    func setFilterViewObserver() {
        filterView
            .filterDidApply
            .subscribe(onNext: { (filter) in
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                self.viewModel.setFilter(filter: filter)
                self.viewModel.fetchDiscovery()
            }, onError: nil, onCompleted: nil, onDisposed: nil
        ).disposed(by: disposeBag)
    }
    
    func setActivityIndicatorObserver() {
        viewModel
            .showActivityIndicator
            .subscribeOn(MainScheduler.asyncInstance)
            .bind { (value) in
                self.showActivitiIndicator(value: value)
        }.disposed(by: disposeBag)
    }
    
    func setErrorHandlerObserver() {
        viewModel
            .handleError
            .bind{ error in
                self.handleError(error)
        }.disposed(by: disposeBag)
    }
    
    func setNetworkConnectionObserver() {
        viewModel
            .showNoNetworkPlaceholder
            .subscribeOn(MainScheduler.asyncInstance)
            .bind { (value) in
                self.showPlaceholder(placehodlerType: .noNetworkConnection, value: value)
        }.disposed(by: disposeBag)
    }
    
    func setEmptyScreenObserver() {
        viewModel
            .showEmptyScreenPlaceholder
            .subscribeOn(MainScheduler.asyncInstance)
            .bind { (value) in
                self.showPlaceholder(placehodlerType: .noMovies, value: value)
        }.disposed(by: disposeBag)

    }
    
    func initObservables() {
        setFilterViewObserver()
        setActivityIndicatorObserver()
        setErrorHandlerObserver()
        setNetworkConnectionObserver()
        setEmptyScreenObserver()
    }
    
    func addFilterView() {
        if view.subviews.contains(filterView) {
            filterView.removeFromSuperview()
            return
        }
        
        filterView.config(with: viewModel.movieFilter)
        self.view.addSubview(filterView)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func handleError(_ error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            self.viewModel.loadMore()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
