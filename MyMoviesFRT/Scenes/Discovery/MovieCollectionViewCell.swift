//
//  MovieCollectionViewCell.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    static let reuseIdentifier = "MovieCollectionViewCell"
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 10
    }
    
    func config(movie: Movie) {
        self.movie = movie
        self.posterImage.sd_setImage(with: URL(string: Constants.imageBaseUrl + "/w500" + movie.posterPath), completed: nil)
    }

}
