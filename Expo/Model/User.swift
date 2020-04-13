//
//  LogIn.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

class User: Identifiable {
    let id: Int
    var name: String
    var username: String
    var password: String
    let isOrganizer: Bool
    var likedExpos = [Expo]()

    func like(_ expo: Expo) {
        likedExpos += [expo]
    }

    func dislike(_ expo: Expo) {
        guard let index = likedExpos.firstIndex(of: expo) else { return }
        likedExpos.remove(at: index)
    }

    func likes(_ expo: Expo) -> Bool {
        return likedExpos.contains(expo)
    }

    init(id: Int, name: String, username: String, password: String, isOrganizer: Bool) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
        self.isOrganizer = isOrganizer
    }

    /// Temporary init w/o backend
    init(name: String, username: String, password: String, isOrganizer: Bool) {
        self.id = User.nextID
        self.name = name
        self.username = username
        self.password = password
        self.isOrganizer = isOrganizer
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

    static var users: [User] = [User(id: 0, name: "John Appleseed", username: "john", password: "12345678", isOrganizer: true),
                                User(id: 1, name: "Nikandr Marhal", username: "nikndr", password: "12345678", isOrganizer: false),
                                User(id: 2, name: "Kyrylo Kundik", username: "kyrylo", password: "12345678", isOrganizer: true)]
    static func add(_ user: User) {
        users.append(user)
    }
    
    static func update(_ user: User, name: String, username: String, password: String) {
        guard let user = users.filter({ $0.username == user.username }).first,
            let index = users.firstIndex(of: user) else { return }
        users[index].name = name
        users[index].username = username
        users[index].password = password
    }

    static func isUsernameAvailable(_ username: String) -> Bool {
        users.allSatisfy { $0.username != username }
    }

    static func getBy(username: String) -> User? {
        users.filter { $0.username == username }.first
    }
}
