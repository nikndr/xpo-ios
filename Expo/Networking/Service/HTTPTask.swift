//
//  HTTPTask.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestparameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestparametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, headers: HTTPHeaders?)
}

enum HTTPHeaderFields: String {
    case contentType = "Content-Type"
}

enum HTTPHeaderValues: String {
    case applicationJSON = "application/json"
    case applicationFormURLEncoded = "application/x-www-form-urlencoded; charset=utf-8"
}
