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
    let name: String
    let login: String
    let email: String
    var isOrganizer: Bool
    var organizedExpos: [Expo]
    // Backend KEKS
    var isSuperadmin: Bool
    var isUser: Bool
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case login
        case email
        case isOrganizer = "organizer_role"
        case isSuperadmin = "superadmin_role"
        case isUser = "user_role"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case organizedExpos = "expos"
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
    func visit(expoID: Int, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        APIClient.visit(userID: id, expoID: expoID, completion: completion)
    }

    func like(_ expo: Expo, value: Bool, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        APIClient.like(userID: id, expoID: expo.id, value: value, completion: completion)
    }

    func like(_ expo: Expo, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        like(expo, value: true, completion: completion)
    }

    func dislike(_ expo: Expo, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        like(expo, value: false, completion: completion)
    }

    func comment(on expo: Expo, with text: String, completion: @escaping (Result<Comment, AFError>) -> Void) {
        APIClient.createComment(userID: id, expoID: expo.id, text: text, completion: completion)
    }
}
