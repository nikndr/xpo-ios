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

    // MARK: Likes and visits

    case like(userID: Int, expoID: Int, value: Bool)
    case visit(userID: Int, expoID: Int)

    // MARK: User

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
        case .like, .visit:
            return .post
        case .updateUser:
            return .put
        }
    }

    var path: String {
        switch self {
        case .like:
            return "/likes"
        case .visit:
            return "/visits"
        case .getAllUsers:
            return "/users"
        case .getUser(let login), .updateUser(let login, _, _, _):
            return "/users/\(login)"
        }
    }

    var task: HTTPTask {
        switch self {
        case .like(let userID, let expoID, let value):
            return .requestWithParametersAndAuth(bodyParameters: [.userID: userID,
                                                                  .expoID: expoID,
                                                                  .liked: value],
                                                 urlParameters: nil)
        case .visit(let userID, let expoID):
            return .requestWithParametersAndAuth(bodyParameters: [.userID: userID,
                                                                  .expoID: expoID],
                                                 urlParameters: nil)
        case .getAllUsers, .getUser:
            return .requestWithAuth

        case .updateUser(_, let newLogin, let newName, let newPassword):
            let parameters: OptionalParameters = [.login: newLogin,
                                                  .name: newName,
                                                  .password: newPassword]
            return .requestWithParametersAndAuth(bodyParameters: JSONParameterEncoder.coalesce(parameters),
                                                 urlParameters: nil)
        }
    }
}
