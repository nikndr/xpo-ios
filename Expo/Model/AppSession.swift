//
//  App.swift
//  Expo
//
//  Created by Nikandr Marhal on 08.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

class AppSession {
    enum SessionState {
        case loggedOut
        case loggedIn(User)
    }

    private(set) var sessinState: SessionState = .loggedOut

    func logIn(withUsername username: String, password: String) {
        // TODO: Networking calls; for now:
        if let user = User.getBy(username: username) {
            sessinState = .loggedIn(user)
        }
    }

    func signUp(withName name: String, username: String, password: String) {
        // TODO: Networking calls; for now:
        if User.isUsernameAvailable(username) {
            let user = User(name: name, username: username, password: password)
            User.add(user)
            sessinState = .loggedIn(user)
        }
    }
    
    func logOut() {
        sessinState = .loggedOut
    }
}
