//
//  HTTPTask.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

typealias KeyedParameters = [ParameterKeys: Any]

enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: KeyedParameters?, urlParameters: KeyedParameters?)
    case download(bodyParameters: KeyedParameters?, urlParameters: KeyedParameters?)
    case upload(bodyParameters: KeyedParameters?, urlParameters: KeyedParameters?)
}

extension KeyedParameters {
    var parameters: Parameters {
        Parameters(uniqueKeysWithValues: map { key, value in (key.rawValue, value) })
    }
}
