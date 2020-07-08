//
//  PlaceholderView.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/8/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit

enum PlaceholderViewType {
    case noMovies
    case noNetworkConnection
    
    var tag: Int {
        switch self {
        case .noMovies:
            return Constants.noMoviesPlaceholderTag
        case .noNetworkConnection:
            return Constants.noNetworkConnectionPlaceholderTag
        }
    }
    
    var iconName: String {
        switch self {
        case .noMovies:
            return "noMovies"
        case .noNetworkConnection:
            return "noNetworkConnection"
        }
    }
    
    var title: String {
        switch self {
        case .noMovies:
            return "Ups... There is no movies"
        case .noNetworkConnection:
            return "No Internet Connection"
        }
    }
    
    var description: String {
        switch self {
        case .noMovies:
            return ""
        case .noNetworkConnection:
            return "Please check your internet connection"
        }
    }
}

class PlaceholderView: UIView {
    
    private lazy var stackView: UIStackView = {
        let sv: UIStackView = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 20
        return sv
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: type.iconName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.type.title
        label.font = UIFont(name: UIFont.AppFonts.openSansSemibold, size: 20)
        label.textColor = UIColor.AppColor.darkBlue
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = self.type.description
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.AppFonts.openSansRegular, size: 14)
        label.textColor = UIColor.AppColor.darkBlue
        label.numberOfLines = 3
        return label
    }()
    
    private let type: PlaceholderViewType
    
    init(type: PlaceholderViewType) {
        self.type = type
        
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.AppColor.lightBlue
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tag = type.tag
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
