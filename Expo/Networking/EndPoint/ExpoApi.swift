//
//  ExpoApi.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum ExpoApi {
    case expo(id: Int)
    case createExpo
}

extension ExpoApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://") else { fatalError("base URL not configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .expo(let id):
            return "/expo/\(id)"
        case .createExpo:
            return "/createExpo"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        .request
    }
    
    var heahers: HTTPHeaders? {
        nil
    }
}
