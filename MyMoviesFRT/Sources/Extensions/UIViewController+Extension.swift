//
//  UIViewController+Extension.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

extension UIViewController {
    class func instantiateFromStoryboard(storyboardName: String, storyboardId: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName, storyboardId: storyboardId)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    func addLogoToNavigationBar() {
        let titleImage = UIImageView(image: UIImage(named: "LogoSmall"))
        titleImage.contentMode = .center
        self.navigationItem.titleView = titleImage
    }
    
    func showActivitiIndicator(value: Bool) {
        switch value {
        case true:
            if view.viewWithTag(Constants.activityIndicatorTag) != nil {
                break
            } else {
                let activityIndicator = MDCActivityIndicator()
                activityIndicator.tag = Constants.activityIndicatorTag
                activityIndicator.cycleColors = [UIColor.AppColor.lightGreen]
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(activityIndicator)
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                activityIndicator.startAnimating()
            }
        case false:
            guard let activityIndicator: MDCActivityIndicator = view.viewWithTag(Constants.activityIndicatorTag) as? MDCActivityIndicator else {
                return
            }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func showPlaceholder(placehodlerType: PlaceholderViewType, value: Bool) {
        if value {
            if view.viewWithTag(placehodlerType.tag) != nil {
                return
            }
        
            let placeholder = PlaceholderView(type: placehodlerType)
            view.addSubview(placeholder)
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            placeholder.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60).isActive = true
            placeholder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        } else {
            guard let placeholder = view.viewWithTag(placehodlerType.tag) else {
                return
            }
            placeholder.removeFromSuperview()
        }
    }
}
