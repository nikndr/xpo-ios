//
//  JSONParameterEncoder.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: HTTPHeaderFields.contentType.rawValue) == nil {
                urlRequest.setValue(HTTPHeaderValues.applicationJSON.rawValue, forHTTPHeaderField: HTTPHeaderFields.contentType.rawValue)
            }
        } catch {
            throw NetworkingError.encodingFailed
        }
    }
}
