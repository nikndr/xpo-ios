//
//  App.swift
//  Expo
//
//  Created by Nikandr Marhal on 08.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum AuthError: String, Error {
    case invalidCredentials = "Cannot proceed with these login and password."
    case usernameTaken = "This username has already been taken"
}

class AppSession {
    enum State {
        case loggedOut
        case loggedIn(User)
    }

    private(set) var state: State
    static let shared = AppSession()

    func logIn(withUsername username: String, password: String, completion: ((Result<User, AuthError>) -> Void)?) {
        // TODO: Networking calls; for now:
        if let user = User.getBy(username: username), user.password == password {
            state = .loggedIn(user)
            updateUserSession()
            completion?(.success(user))
        } else {
            completion?(.failure(.invalidCredentials))
        }
    }

    func signUp(withName name: String, username: String, password: String, isOrganizer: Bool, completion: ((Result<User, AuthError>) -> Void)?) {
        // TODO: Networking calls; for now:
        if User.isUsernameAvailable(username) {
            let user = User(name: name, username: username, password: password, isOrganizer: isOrganizer)
            User.add(user)
            state = .loggedIn(user)
            updateUserSession()
            completion?(.success(user))
        } else {
            completion?(.failure(.usernameTaken))
        }
    }

    func logOut(completion: (() -> Void)?) {
        state = .loggedOut
        updateUserSession()
        completion?()
    }
    
    func updateUser(_ user: User) {
        state = .loggedIn(user)
    }

    private func updateUserSession() {
        let defaults = UserDefaults.standard
        switch state {
        case .loggedIn(let user):
            defaults.setValue(value: user.id, forKey: .userID)
            defaults.setValue(value: user.name, forKey: .name)
            defaults.setValue(value: user.username, forKey: .username)
            defaults.setValue(value: user.password, forKey: .password)
            defaults.setValue(value: user.isOrganizer, forKey: .isOrganizer)
        case .loggedOut:
            defaults.setValue(value: nil, forKey: .userID)
            defaults.setValue(value: nil, forKey: .name)
            defaults.setValue(value: nil, forKey: .username)
            defaults.setValue(value: nil, forKey: .password)
            defaults.setValue(value: nil, forKey: .isOrganizer)
        }
    }

    private init() {
        let defaults = UserDefaults.standard
        if let id = defaults.integer(forKey: .userID),
            let name = defaults.string(forKey: .name),
            let username = defaults.string(forKey: .username),
            let password = defaults.string(forKey: .password) {
            let isOrganizer = defaults.bool(forKey: .isOrganizer)
            let user = User(id: id, name: name, username: username, password: password, isOrganizer: isOrganizer)
            self.state = .loggedIn(user)
        } else {
            self.state = .loggedOut
        }
    }
}
