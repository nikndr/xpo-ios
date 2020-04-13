//
//  UserRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum AuthEndPoint {
    // MARK: - Endpoints

    case login(login: String, password: String)
    case signup(login: String, email: String, password: String, name: String, isOrganizer: Bool)
}

// MARK: - EndPointType

extension AuthEndPoint: EndPointType {
    var method: HTTPMethod {
        switch self {
        case .login, .signup:
            return .post
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        }
    }

    var task: HTTPTask {
        switch self {
        case .login(let login, let password):
            return .requestWithParameters(bodyParameters: [.login: login,
                                                           .password: password],
                                          urlParameters: nil)
        case .signup(let login, let email, let password, let name, let isOrganizer):
            return .requestWithParameters(bodyParameters: [.login: login,
                                                           .email: email,
                                                           .password: password,
                                                           .name: name,
                                                           .organizerRole: isOrganizer],
                                          urlParameters: nil)
        }
    }
}
