//
//  MoviesCollectionView.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/8/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit
import RxSwift

class MoviesCollectionView: UICollectionView {
    
    var loadMore = PublishSubject<Void>.init()
    let disposeBag = DisposeBag()
    
    init(frame: CGRect) {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let height = (frame.width - 24) * 0.75 + 16
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        
        super.init(frame: frame, collectionViewLayout: UICollectionViewCompositionalLayout(section: section))
        
        self.backgroundColor = UIColor.AppColor.lightBlue
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        self.rx
            .contentOffset
            .subscribe(onNext: { (point) in
                let offsetY = point.y
                let contentHeight = self.contentSize.height
                if offsetY > contentHeight - self.frame.size.height {
                    self.loadMore.onNext(())
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil
        ).disposed(by: disposeBag)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let height = (self.bounds.width - 24) * 0.75 + 16
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
