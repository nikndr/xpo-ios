//
//  ParameterEncoder.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

typealias OptionalParameters = [ParameterKeys: Any?]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

extension ParameterEncoder {
    static func coalesce(_ optionalParameters: OptionalParameters) -> KeyedParameters {
        optionalParameters
            .filter { $0.value != nil }
            .mapValues { $0! }
    }
}
