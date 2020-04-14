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
            return "/auth/login"
        case .signup:
            return "/auth/signup"
        }
    }

    var task: HTTPTask {
        switch self {
        case .login(let login, let password):
            return .requestWithParameters(bodyParameters: [.user: [ParameterKeys.login.rawValue: login,
                                                                   ParameterKeys.password.rawValue: password]],
                                          urlParameters: nil)
        case .signup(let login, let email, let password, let name, let isOrganizer):
            return .requestWithParameters(bodyParameters: [.user: [ParameterKeys.login.rawValue: login,
                                                                   ParameterKeys.email.rawValue: email,
                                                                   ParameterKeys.password.rawValue: password,
                                                                   ParameterKeys.name.rawValue: name,
                                                                   ParameterKeys.organizerRole.rawValue: isOrganizer]],
                                          urlParameters: nil)
        }
    }
}
