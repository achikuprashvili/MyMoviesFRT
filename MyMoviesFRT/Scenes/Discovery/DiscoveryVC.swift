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

@available(iOS 13.0, *)
class DiscoveryVC: UIViewController, MVVMViewController {
    
    var viewModel: DiscoveryVMProtocol!
    let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        initObservables()
    }
    
    func initCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .red
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewModel.movies.bind(to: collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.reuseIdentifier)) { collectionView, movie, cell in
            let cellToUse = cell as! MovieCollectionViewCell
            cellToUse.config(movie: movie)
        }.disposed(by: disposeBag)
        
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
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
