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
        addSortByTitle()
        addTableView()
        addApplyButton()
        addSeparatorLine()
        addUserScoreTitle()
        addRateSlider()
    }
    
    func config(with filter: MovieFilter) {
        self.filter = filter
        guard let index = MovieSortOptions.allCases.firstIndex(of: filter.sortBy) else {
            return
        }
        sortByTableView.selectRow(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSortByTitle() {
        addSubview(sortByTitle)
        sortByTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        sortByTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        sortByTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
    }
    
    func addUserScoreTitle() {
        addSubview(userScoreTitle)
        userScoreTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        userScoreTitle.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 15).isActive = true
        userScoreTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
    }
    
    func addTableView() {
        self.addSubview(sortByTableView)
        sortByTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sortByTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
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
        addSubview(separatorLine)
        separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        separatorLine.topAnchor.constraint(equalTo: sortByTableView.bottomAnchor, constant: 15).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func addRateSlider() {
        addSubview(rateSlider)
        rateSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        rateSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        rateSlider.topAnchor.constraint(equalTo: userScoreTitle.bottomAnchor, constant: 5).isActive = true
        rateSlider.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
