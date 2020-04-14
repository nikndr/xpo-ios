//
//  UserToExpoAction.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct UserToExpo: Codable {
    let userID: Int
    let expoID: Int
    
    enum UserToExpoCodingKeys: String, CodingKey {
        case userID = "user_id"
        case expoID = "expo_id"
    }
}
