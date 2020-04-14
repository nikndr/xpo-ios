//
//  App.swift
//  Expo
//
//  Created by Nikandr Marhal on 08.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

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

    func logIn(withUsername username: String, password: String, completion: ((Result<User, AFError>) -> Void)?) {
        APIClient.login(login: username, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.state = .loggedIn(user)
                self.updateUserSession()
                completion?(.success(user))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    func signUp(withName name: String, username: String, email: String, password: String, isOrganizer: Bool, completion: ((Result<User, AFError>) -> Void)?) {
        APIClient.signUp(name: name, username: username, password: password, isOrganizer: isOrganizer, email: email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.state = .loggedIn(user)
                self.updateUserSession()
                completion?(.success(user))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    func logOut(completion: (() -> Void)?) {
        state = .loggedOut
        updateUserSession()
        completion?()
    }

    func updateUser(newName: String?, newLogin: String?, newPassword: String?, completion: ((Result<User, AFError>) -> Void)?) {
        if case .loggedIn(let user) = state {
            APIClient.updateUser(login: user.login, newLogin: newLogin, newName: newName, newPassword: newPassword) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.state = .loggedIn(user)
                    self.updateUserSession()
                    completion?(.success(user))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }
    }

    private func updateUserSession() {
        let defaults = UserDefaults.standard
        switch state {
        case .loggedIn(let user):
            defaults.setValue(value: user.id, forKey: .userID)
            defaults.setValue(value: user.name, forKey: .name)
            defaults.setValue(value: user.login, forKey: .username)
            defaults.setValue(value: user.email, forKey: .email)
            defaults.setValue(value: user.isOrganizer, forKey: .isOrganizer)
        case .loggedOut:
            defaults.setValue(value: nil, forKey: .userID)
            defaults.setValue(value: nil, forKey: .name)
            defaults.setValue(value: nil, forKey: .username)
            defaults.setValue(value: nil, forKey: .email)
            defaults.setValue(value: nil, forKey: .isOrganizer)
            defaults.setValue(value: nil, forKey: .jwt)
        }
    }

    private init() {
        let defaults = UserDefaults.standard
        if let id = defaults.integer(forKey: .userID),
            let name = defaults.string(forKey: .name),
            let username = defaults.string(forKey: .username),
            let email = defaults.string(forKey: .email),
            let _ = defaults.string(forKey: .jwt) {
            let isOrganizer = defaults.bool(forKey: .isOrganizer)
            let user = User(id: id, name: name, username: username, isOrganizer: isOrganizer, email: email)
            self.state = .loggedIn(user)
        } else {
            self.state = .loggedOut
        }
    }
}
