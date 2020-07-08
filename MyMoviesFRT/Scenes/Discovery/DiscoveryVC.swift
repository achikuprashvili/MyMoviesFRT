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
    @IBOutlet weak var moviewSectionSegmentControll: UISegmentedControl!
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLogoToNavigationBar()
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        button.rx.tap.bind {
            print("tap button")
        }.disposed(by: disposeBag)
        setupUI()
        initCollectionView()
        initObservables()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.AppColor.lightBlue
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
                case 1:
                    self.viewModel.showFavoriteMovies()
                default:
                    break
                }
            }, onError: { (error) in
            }, onCompleted: nil
            , onDisposed: nil).disposed(by: disposeBag)
    }
    
    func initCollectionView() {
        collectionView = MoviesCollectionView(frame: view.bounds)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: moviewSectionSegmentControll.bottomAnchor, constant: 15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
    }
    
    
    func initObservables() {
        viewModel
            .networkIsReachable
            .subscribeOn(MainScheduler.asyncInstance)
            .bind { (value) in
                print("network is \(value)")
        }.disposed(by: disposeBag)
        
        viewModel
            .screenState
            .subscribeOn(MainScheduler.asyncInstance)
            .bind { (state) in
                print(state)
        }.disposed(by: disposeBag)
    }
}
