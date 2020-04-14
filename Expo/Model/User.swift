//
//  LogIn.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire
import Foundation

class User: Identifiable, Codable {
    let id: Int
    var name: String
    var login: String
    var email: String
    let isOrganizer: Bool
    // Backend KEKS
    let isSuperadmin: Bool
    let isUser: Bool
    let createdAt: Date
    var updatedAt: Date

    init(id: Int, name: String, username: String, isOrganizer: Bool, email: String) {
        self.id = id
        self.name = name
        self.login = username
        self.isOrganizer = isOrganizer
        self.email = email
        self.isSuperadmin = false
        self.isUser = true
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    enum UserCodingKeys: String, CodingKey {
        case id
        case name
        case login
        case email
        case isOrganizer = "organizer_role"
        case isSuperadmin = "superadmin_role"
        case isUser = "user_role"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    required init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)

        self.id = try userContainer.decode(Int.self, forKey: .id)
        self.name = try userContainer.decode(String.self, forKey: .name)
        self.login = try userContainer.decode(String.self, forKey: .login)
        self.email = try userContainer.decode(String.self, forKey: .email)
        self.isOrganizer = try userContainer.decode(Bool.self, forKey: .isOrganizer)
        self.isSuperadmin = try userContainer.decode(Bool.self, forKey: .isSuperadmin)
        self.isUser = try userContainer.decode(Bool.self, forKey: .isUser)
        self.createdAt = try userContainer.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try userContainer.decode(Date.self, forKey: .updatedAt)
    }
}

extension User: Hashable, Equatable {
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Accessing remote data

extension User {
    func getOrganizedExpos(completion: @escaping (Result<[Expo], AFError>) -> Void) {
        APIClient.getAllExpos(organizerID: id, completion: completion)
    }
    
    func visit(expoID: Int, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        APIClient.visit(userID: id, expoID: expoID, completion: completion)
    }

    func like(_ expo: Expo, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        APIClient.like(userID: id, expoID: expo.id, completion: completion)
    }

    func dislike(_ expo: Expo) {}

    func likes(_ expo: Expo) -> Bool {
        false
    }
}
