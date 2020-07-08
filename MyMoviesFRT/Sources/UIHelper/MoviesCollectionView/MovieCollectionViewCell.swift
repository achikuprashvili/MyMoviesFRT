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
        self.posterImage.contentMode = .center
        self.posterImage.sd_setImage(with: URL(string: Constants.imageBaseUrl + "/w500" + (movie.posterPath ?? " ")), placeholderImage: UIImage(named: "imagePlaceholder")?.withTintColor(UIColor.AppColor.darkBlue), options: SDWebImageOptions.retryFailed) { (image, error, cache, url) in
            guard image != nil else {
                self.posterImage.contentMode = .center
                return
            }
            self.posterImage.contentMode = .scaleAspectFill
        }
        
    }

}
