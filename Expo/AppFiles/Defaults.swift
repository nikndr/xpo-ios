//
//  Defaults.swift
//  Expo
//
//  Created by Nikandr Marhal on 30.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum Defaults: String {
    case userID
    case name
    case username
    case password
    case isOrganizer
}

extension UserDefaults {
    func bool(forKey key: Defaults) -> Bool {
        bool(forKey: key.rawValue)
    }
    
    func string(forKey key: Defaults) -> String? {
        string(forKey: key.rawValue)
    }
    
    func integer(forKey key: Defaults) -> Int? {
        integer(forKey: key.rawValue)
    }

    func setValue(value: Any?, forKey key: Defaults) {
        setValue(value, forKey: key.rawValue)
    }
}
