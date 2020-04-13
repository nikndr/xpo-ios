//
//  DateFromatting.swift
//  Expo
//
//  Created by Nikandr Marhal on 09.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum DateTimeFormats: String {
    case dateSeparatedByPeriods = "MM.dd.yyyy"
    case timeSeparatedByColon = "HH:mm"
    case dateAndTime = "MM.dd.yyyy, HH:mm"
}

func formattedDateTime(from date: Date, withFormat format: DateTimeFormats) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    return "\(formatter.string(from: date))"
}

func formatTimeString(from date: Date, format: DateTimeFormats = .timeSeparatedByColon) -> String {
    formattedDateTime(from: date, withFormat: format)
}

func formatDateString(from date: Date, format: DateTimeFormats = .dateSeparatedByPeriods) -> String {
    formattedDateTime(from: date, withFormat: format)
}

func formatTimeInterval(startDate: Date, endDate: Date, format: DateTimeFormats = .dateAndTime) -> String {
    "\(formattedDateTime(from: startDate, withFormat: format))–\(formattedDateTime(from: endDate, withFormat: format))"
}
