//
//  UserRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum AuthEndPoint: EndPointType {
    // MARK: - Endpoints

    case login(login: String, password: String)
    case signup(login: String, email: String, password: String, name: String, isOrganizer: Bool)

    // MARK: - API Configuration

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

    var parameters: Parameters? {
        switch self {
        case .login(let login, let password):
            return [ParameterKeys.login.rawValue: login,
                    ParameterKeys.password.rawValue: password]
        case .signup(let login, let email, let password, let name, let isOrganizer):
            return [ParameterKeys.login.rawValue: login,
                    ParameterKeys.email.rawValue: email,
                    ParameterKeys.password.rawValue: password,
                    ParameterKeys.name.rawValue: name,
                    ParameterKeys.organizerRole.rawValue: isOrganizer]
        }
    }
}
