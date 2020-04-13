//
//  ExpoRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum ExpoRouter: EndPointType {
    // MARK: - Endpoints
    case like(userID: Int, expoID: Int)
    case visit(userID: Int, expoID: Int)
    // MARK: - API Configuration
    var method: HTTPMethod
    
    var path: String
    
    var parameters: Parameters?
}
