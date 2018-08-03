//
//  DateFormatter+Changelly.swift
//  Quids
//
//  Created by Red Davis on 21/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal extension DateFormatter
{
    internal static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
}
