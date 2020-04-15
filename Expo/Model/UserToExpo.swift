//
//  UserToExpoAction.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct UserToExpo: Codable {
    let id: Int
    let userID: Int
    let expoID: Int
    var liked: Bool
    let createdAt: Date
    var updatedAt: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.userID = try container.decode(Int.self, forKey: .userID)
        self.expoID = try container.decode(Int.self, forKey: .expoID)
        self.liked = try container.decode(Bool.self, forKey: .liked)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}

extension UserToExpo {
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case expoID = "expo_id"
        case liked
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
