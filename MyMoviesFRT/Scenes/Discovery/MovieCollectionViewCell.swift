//
//  MovieCollectionViewCell.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "MovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .black
    }
    
    func config(movie: Movie) {
        self.backgroundColor = .black
    }

}
