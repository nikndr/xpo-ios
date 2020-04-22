//
//  Constants.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

struct K {
    struct Production {
        static let baseURL = "https://xpo.restful-api.site"
    }
    
    struct Imgur {
        static let clientID = "Client-ID 220f05894cb9cd1"
        static let baseURL = "https://api.imgur.com/3"
    }
}

enum HTTPHeaderField: String {
    case auth = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case clientID = "Client-ID"
}

enum ContentType: String {
    case json = "application/json"
}

