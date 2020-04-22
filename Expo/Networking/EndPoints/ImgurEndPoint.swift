//
//  ImgurEndPoint.swift
//  Expo
//
//  Created by Nikandr Marhal on 21.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum ImgurEndPoint: EndPointType {
    case upload(photo: Data)
    
    var baseURL: URL {
        guard let url = URL(string: K.Imgur.baseURL) else { fatalError("Base url cannot be loaded") }
        return url
    }
    
    var method: HTTPMethod {
        switch self {
        case .upload:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .upload:
            return "/upload"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .upload(let photo):
            return .requestWithParametersAndHeaders(bodyParameters: [.upload: photo], urlParameters: nil, headers: [HTTPHeader.authorization(K.Imgur.clientID)])
        }
    }
}
