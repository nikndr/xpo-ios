//
//  APIConfiguration.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

protocol EndPointType: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var task: HTTPTask { get }
}

extension URLRequestConvertible where Self: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: K.Production.baseURL) else { fatalError("Base url cannot be loaded") }
        return url
    }

    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))

        request.httpMethod = method.rawValue
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        do {
            switch task {
            case .request:
                break
            case .requestWithAuth:
                guard let authToken = UserDefaults.standard.string(forKey: .jwt) else { throw NetworkError.unauthorized }
                addHeaders([HTTPHeader.authorization(authToken)], request: &request)
            case .requestWithParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters?.parameters,
                                        urlParameters: urlParameters?.parameters,
                                        request: &request)
            case .requestWithParametersAndAuth(let bodyParameters, let urlParameters):
                guard let authToken = UserDefaults.standard.string(forKey: .jwt) else { throw NetworkError.unauthorized }
                addHeaders([HTTPHeader.authorization(authToken)], request: &request)
                try configureParameters(bodyParameters: bodyParameters?.parameters,
                                        urlParameters: urlParameters?.parameters,
                                        request: &request)
            case .requestWithParametersAndHeaders(let bodyParameters,
                                                  let urlParameters,
                                                  let headers):
                addHeaders(headers, request: &request)
                try configureParameters(bodyParameters: bodyParameters?.parameters,
                                        urlParameters: urlParameters?.parameters,
                                        request: &request)
            case .download, .upload:
                fatalError("Not implemented")
            }

            return request
        } catch {
            throw error
        }
    }

    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    private func addHeaders(_ headers: [HTTPHeader]?, request: inout URLRequest) {
        guard let headers = headers else { return }
        headers.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.name)
        }
    }
}
