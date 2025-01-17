//
//  MVVMViewController.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/6/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

protocol MVVMViewController: class {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
}
