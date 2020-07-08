//
//  UIView+Extension.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient(colours: [UIColor], locations: [NSNumber]? = nil){
        self.clipsToBounds = false
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 2.0
        self.layer.insertSublayer(gradient, at: 0)
    }
}
