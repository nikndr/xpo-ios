//
//  CommentsRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum CommentsEndPoint {
    // MARK: - Endpoints

    case getAllComments
    case getComment(commentID: Int)
    case createComment(userID: Int, expoID: Int, text: String)
    case updateComment(commentID: Int, text: String)
    case deleteComment(commentID: Int)
}

// MARK: - EndPointType

extension CommentsEndPoint: EndPointType {
    var method: HTTPMethod {
        switch self {
        case .getAllComments, .getComment:
            return .get
        case .createComment:
            return .post
        case .updateComment:
            return .put
        case .deleteComment:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .getAllComments, .createComment:
            return "/comment"
        case .getComment(let commentID), .updateComment(let commentID, _), .deleteComment(let commentID):
            return "/comment/\(commentID)"
        }
    }

    var task: HTTPTask {
        switch self {
        case .getAllComments:
            return .requestWithAuth
        case .getComment, .deleteComment:
            return .requestWithAuth
        case .createComment(let userID, let expoID, let text):
            return .requestWithParametersAndAuth(bodyParameters: [.userID: userID,
                                                                  .expoID: expoID,
                                                                  .text: text],
                                                 urlParameters: nil)
        case .updateComment(_, let text):
            return .requestWithParametersAndAuth(bodyParameters: [.text: text],
                                                 urlParameters: nil)
        }
    }
}
