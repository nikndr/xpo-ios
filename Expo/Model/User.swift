//
//  LogIn.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct User: Identifiable {
    var id: Int
    var name: String
    var username: String
    var isOrganiser: Bool

    static var users: [User] = [User(id: 0, name: "John Appleseed", username: "john", isOrganiser: false),
                                User(id: 1, name: "Nikandr Marhal", username: "nikndr", isOrganiser: true),
                                User(id: 2, name: "Kyrylo Kundik", username: "kyrylo", isOrganiser: true)]
}

extension User: Hashable {
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(username)
        hasher.combine(isOrganiser)
    }
}
