//
//  Comment.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation
import Alamofire

struct Comment: Identifiable, Codable {
    let id: Int
    let userName: String
    let expoID: Int
    let text: String
    let likesCount: Int
    let createdAt: Date
    var updatedAt: Date

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case expoID = "expo_id"
        case text
        case likesCount = "likes_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

//    init(decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CommentCodingKeys.self)
//
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.userID = try container.decode(Int.self, forKey: .userID)
//        self.expoID = try container.decode(Int.self, forKey: .expoID)
//        self.text = try container.decode(String.self, forKey: .text)
//        self.likesCount = try container.decode(Int.self, forKey: .likesCount)
//        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
//        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
//    }
}

// MARK: - Conformation to Comparable

extension Comment: Comparable {
    static func < (lhs: Comment, rhs: Comment) -> Bool {
        lhs.updatedAt < rhs.updatedAt
    }
}

// MARK: - Network actions

extension Comment {
    func delete(completion: @escaping (Result<Comment, AFError>) -> Void) {
        APIClient.deleteComment(commentID: id, completion: completion)
    }
}
