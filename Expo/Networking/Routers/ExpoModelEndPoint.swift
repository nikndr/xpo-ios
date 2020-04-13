//
//  ExpoModelRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum ExpoModelRouter: EndPointType {
    // MARK: - Endpoints
    // MARK: - API Configuration
    var method: HTTPMethod

    var path: String

    var parameters: Parameters?
}
