//
//  DateFromatting.swift
//  Expo
//
//  Created by Nikandr Marhal on 09.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation



extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    enum DateTimeFormats: String {
        case dateSeparatedByPeriods = "MM.dd.yyyy"
        case timeSeparatedByColon = "HH:mm"
        case dateAndTime = "MM.dd.yyyy, HH:mm"
    }

    class func formattedDateTime(from date: Date, withFormat format: DateTimeFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return "\(formatter.string(from: date))"
    }

    class func formatTimeString(from date: Date, format: DateTimeFormats = .timeSeparatedByColon) -> String {
        formattedDateTime(from: date, withFormat: format)
    }

    class func formatDateString(from date: Date, format: DateTimeFormats = .dateSeparatedByPeriods) -> String {
        formattedDateTime(from: date, withFormat: format)
    }

    class func formatTimeInterval(startDate: Date, endDate: Date, format: DateTimeFormats = .dateAndTime) -> String {
        "\(formattedDateTime(from: startDate, withFormat: format))–\(formattedDateTime(from: endDate, withFormat: format))"
    }
}
