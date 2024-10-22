//
//  Date+Extensions.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

extension Date {
    var formattedDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: self)
    }
}
