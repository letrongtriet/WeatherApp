//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import Foundation

extension Date {
    var hourMinuteDisplayString: String? {
        "Updated: \(DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short))"
    }
}
