//
//  ParameterEncoding.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum NetworkingError: String, Error {
    case parametersNil = "Given paramters were nil"
    case encodingFailed = "Encodinf was unsuccessfull"
    case missingURL = "URL is nil"
}
