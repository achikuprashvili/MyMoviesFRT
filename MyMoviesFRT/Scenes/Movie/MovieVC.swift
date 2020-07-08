//
//  MovieVC.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class MovieVC: UIViewController, MVVMViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var manageFavouriteButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel: MovieVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        ratingLabel.text = viewModel.getRating()
        titleLabel.text = viewModel.getTitle()
        originalTitleLabel.text = viewModel.getOriginalTitle()
        releaseDate.text = "Release date: \(viewModel.getReleaseDate())"
        overviewLabel.text = viewModel.getOverView()
        posterImage.sd_setImage(with: viewModel.getPosterUrl(), placeholderImage: UIImage(named: "imagePlaceholder"), options: .retryFailed) { (image, error, type, url) in
            if image != nil {
                self.posterImage.contentMode = .scaleAspectFill
            }
        }
        
        viewModel
            .isMovieFavourite
            .subscribeOn(MainScheduler.asyncInstance)
            .bind { (value) in
                let buttonTitle = value ? "Remove from favourite" : "Add to favourite"
                self.manageFavouriteButton.setTitle(buttonTitle, for: .normal)
        }.disposed(by: disposeBag)
        
        manageFavouriteButton.rx.tap.bind { () in
            do {
                if try self.viewModel.isMovieFavourite.value() {
                    self.viewModel.removeMovieFromFavourite()
                } else {
                    self.viewModel.addToFavourite()
                }
            } catch {
            }
        }.disposed(by: disposeBag)
    }
    
}
