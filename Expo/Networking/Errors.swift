//
//  Errors.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL = "The URL of the request is missing"
    case encodingFailed = "Encoding of parameters has failed"
    case unauthorized
}
