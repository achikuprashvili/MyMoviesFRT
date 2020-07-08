//
//  SortByTableViewCell.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/8/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit

class SortByTableViewCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    static let reuseIdentifier = "SortByTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        titleLabel.textColor = UIColor.AppColor.lightGreen
        titleLabel.font = UIFont.AppFonts.openSansSemibold(with: 15)
        markImage.image = markImage.image?.withTintColor(UIColor.AppColor.lightGreen)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .clear
        markImage.isHidden = !selected
    }
    
    func config(data: MovieSortOptions) {
        titleLabel.text = data.title
    }
    
}
