//
//  UserRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum UserEndPoint {
    // MARK: - Endpoints

    case getAllUsers
    case getUser(login: String)
    case updateUser(login: String, newLogin: String?, newName: String?, newPassword: String?)
}

// MARK: - EndPointType

extension UserEndPoint: EndPointType {
    var method: HTTPMethod {
        switch self {
        case .getAllUsers, .getUser:
            return .get
        case .updateUser:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getAllUsers:
            return "/users"
        case .getUser(let login), .updateUser(let login, _, _, _):
            return "/users/\(login)"
        }
    }

    var task: HTTPTask {
        switch self {
        case .getAllUsers, .getUser:
            return .request
        case .updateUser(_, let newLogin, let newName, let newPassword):
            let parameters: OptionalParameters = [.login: newLogin,
                                                  .name: newName,
                                                  .password: newPassword]
            return .requestWithParameters(bodyParameters: JSONParameterEncoder.coalesce(parameters),
                                          urlParameters: nil)
        }
    }
}
