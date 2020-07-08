//
//  UIFont+Extension.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/8/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import UIKit

extension UIFont {
    
    struct AppFonts {
        static let openSansBold = "OpenSans-Bold"
        static let openSansSemibold = "OpenSans-Semibold"
        static let openSansRegular = "OpenSans"
        
        static func openSansBold(with size: CGFloat) -> UIFont {
            return UIFont(name: UIFont.AppFonts.openSansBold, size: size)!
        }
        
        static func openSansSemibold(with size: CGFloat) -> UIFont {
            return UIFont(name: UIFont.AppFonts.openSansSemibold, size: size)!
        }

        static func openSansRegular(with size: CGFloat) -> UIFont {
            return UIFont(name: UIFont.AppFonts.openSansRegular, size: size)!
        }

    }
}
