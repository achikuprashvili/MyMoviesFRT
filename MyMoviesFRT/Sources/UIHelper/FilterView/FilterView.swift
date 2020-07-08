//
//  FilterView.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit
import RxSwift
import RangeSeekSlider

class FilterView: UIView {
    
    var sortByDataSource = PublishSubject<[MovieSortOptions]>.init()
    let disposeBag = DisposeBag()
    var filterDidApply = PublishSubject<MovieFilter>.init()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return UIScrollView()
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColor.lightGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sortByTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: SortByTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SortByTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.bounces = false
        return tableView
    }()
    
    lazy var sortByTitle: UILabel = {
        let label = UILabel()
        label.text = "Sort By"
        label.textColor = UIColor.AppColor.lightBlue
        label.font = UIFont.AppFonts.openSansSemibold(with: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userScoreTitle: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.textColor = UIColor.AppColor.lightBlue
        label.font = UIFont.AppFonts.openSansSemibold(with: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(UIColor.AppColor.darkBlue, for: .normal)
        button.backgroundColor = UIColor.AppColor.lightGreen
        button.titleLabel?.font = UIFont.AppFonts.openSansSemibold(with: 18)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var rateSlider: RangeSeekSlider = {
        let slider = RangeSeekSlider()
        slider.minValue = 0
        slider.selectedMaxValue = 0
        slider.maxValue = 10
        slider.selectedMaxValue = 10
        slider.enableStep = true
        slider.step = 0.1
        slider.lineHeight = 3
        slider.colorBetweenHandles = UIColor.AppColor.lightGreen
        slider.handleColor = UIColor.AppColor.lightGreen
        slider.maxLabelColor = UIColor.AppColor.lightGreen
        slider.minLabelColor = UIColor.AppColor.lightGreen
        slider.maxLabelFont = UIFont.AppFonts.openSansRegular(with: 13)
        slider.minLabelFont = UIFont.AppFonts.openSansRegular(with: 13)
        slider.handleBorderColor = .white
        slider.tintColor = UIColor.AppColor.lightBlue
        slider.handleBorderWidth = 2
        slider.handleDiameter = 20
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var filter: MovieFilter = MovieFilter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.AppColor.darkBlue
        addApplyButton()
        addScrollView()
        addSortByTitle()
        addTableView()
        addSeparatorLine()
        addUserScoreTitle()
        addRateSlider()
    }
    
    func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -20).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func config(with filter: MovieFilter) {
        self.filter = filter
        guard let index = MovieSortOptions.allCases.firstIndex(of: filter.sortBy) else {
            return
        }
        sortByTableView.selectRow(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .none)
        rateSlider.selectedMaxValue = CGFloat(filter.maxRating)
        rateSlider.selectedMinValue = CGFloat(filter.minRating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSortByTitle() {
        contentView.addSubview(sortByTitle)
        sortByTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        sortByTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        sortByTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
    }
    
    func addUserScoreTitle() {
        contentView.addSubview(userScoreTitle)
        userScoreTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        userScoreTitle.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 15).isActive = true
        userScoreTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
    }
    
    func addTableView() {
        contentView.addSubview(sortByTableView)
        sortByTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        sortByTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        sortByTableView.topAnchor.constraint(equalTo: sortByTitle.bottomAnchor).isActive = true
        sortByTableView.heightAnchor.constraint(equalToConstant: CGFloat(MovieSortOptions.allCases.count * 40)).isActive = true
        
        sortByDataSource.bind(to: self.sortByTableView.rx.items(cellIdentifier: SortByTableViewCell.reuseIdentifier)) { index, item, cell in
            let cellToUse = cell as! SortByTableViewCell
            cellToUse.config(data: item)
        }.disposed(by: disposeBag)
        
        sortByTableView
            .rx
            .modelSelected(MovieSortOptions.self)
            .subscribe(onNext: { (item) in
                self.filter.sortBy = item
            }, onError: nil, onCompleted: nil, onDisposed: nil
        ).disposed(by: disposeBag)
        
        sortByDataSource.onNext(MovieSortOptions.allCases)
    }
    
    func addApplyButton() {
        self.addSubview(applyButton)
        applyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        applyButton.rx.tap.bind {
            self.filter.maxRating = Double(self.rateSlider.selectedMaxValue)
            self.filter.minRating = Double(self.rateSlider.selectedMinValue)
            self.filterDidApply.onNext(self.filter)
            self.removeFromSuperview()
        }.disposed(by: disposeBag)
    }
    
    func addSeparatorLine() {
        contentView.addSubview(separatorLine)
        separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        separatorLine.topAnchor.constraint(equalTo: sortByTableView.bottomAnchor, constant: 15).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func addRateSlider() {
        contentView.addSubview(rateSlider)
        rateSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        rateSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        rateSlider.topAnchor.constraint(equalTo: userScoreTitle.bottomAnchor, constant: 5).isActive = true
        rateSlider.heightAnchor.constraint(equalToConstant: 44).isActive = true
        rateSlider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
    }
}
