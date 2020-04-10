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
    var password: String
    
    init(id: Int, name: String, username: String, password: String) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
    }
    
    /// Temporary init w/o backend
    init(name: String, username: String, password: String) {
        self.id = User.nextID
        self.name = name
        self.username = username
        self.password = password
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


// MARK: - Database xDxDxD

extension User {
    static var nextID: Int {
        users.count
    }

    static var users: [User] = [User(id:0,name: "John Appleseed", username: "john", password: "12345678"),
                                User(id:1,name: "Nikandr Marhal", username: "nikndr", password: "12345678"),
                                User(id:2,name: "Kyrylo Kundik", username: "kyrylo", password: "12345678")]
    static func add(_ user: User) {
        users.append(user)
    }

    static func isUsernameAvailable(_ username: String) -> Bool {
        users.allSatisfy { $0.username != username }
    }
    
    static func getBy(username: String) -> User? {
        users.filter { $0.username == username }.first
    }
}
