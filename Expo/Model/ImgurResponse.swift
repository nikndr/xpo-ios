//
//  ImgurResponse.swift
//  Expo
//
//  Created by Nikandr Marhal on 21.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct ImgurResponse: Codable {
    let data: DataClass
    let success: Bool
    let status: Int
}

struct DataClass: Codable {
    let link: String
}
