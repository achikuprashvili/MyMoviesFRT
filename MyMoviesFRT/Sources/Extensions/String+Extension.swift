//
//  String+Extension.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/8/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation

extension String {
    func getUserFriendlyDateString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return self
        }
    }
}
