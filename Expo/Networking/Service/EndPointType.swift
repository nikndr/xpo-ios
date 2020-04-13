//
//  APIConfiguration.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

protocol EndPointType: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
//    var parameters: Parameters? { get }
    var task: HTTPTask { get }
}

extension URLRequestConvertible where Self: EndPointType {
    /// Default implementation accepts and produces Content-Type: application/json
    /// Override to provide custom behaviour
    func asURLRequest() throws -> URLRequest {
        let url = try K.Production.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

//        urlRequest.httpMethod = method.rawValue
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//
//        if let parameters = parameters {
//            do {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//            } catch {
//                throw AFError.parameterEncoderFailed(reason: .encoderFailed(error: error))
//            }
//        }

        return urlRequest
    }
}
