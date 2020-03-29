//
//  Expo.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct Expo: Identifiable {
    var id: Int
    var organizer: User
    var name: String
    var description: String
    var imageURL: String
    var startTime: Date
    var endTime: Date
    var locationName: String
    var models: [ARModel]

    static var expos: [Expo] = [
        Expo(id: 0, organizer: User.users[1], name: "Expo 1", description: "Very good expo", imageURL: "https://nova.lc/wp-content/uploads/2020/01/dubai-.jpg", startTime: Date(), endTime: Date(), locationName: "Apple Park", models: ARModel.models),
        Expo(id: 1, organizer: User.users[2], name: "Expo 2", description: "Very good expo, but another", imageURL: "https://i.imgur.com/qcVM19M.jpg", startTime: Date(), endTime: Date(), locationName: "Kyiv", models: ARModel.models),
        Expo(id: 2, organizer: User.users[1], name: "Expo 3", description: "Please don't visit this expo", imageURL: "https://i.imgur.com/lBizl0j.jpg", startTime: Date(), endTime: Date(), locationName: "Cherkasy", models: ARModel.models),
    ]
}

extension Expo: Hashable {
    static func ==(lhs: Expo, rhs: Expo) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(organizer)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(imageURL)
        hasher.combine(startTime)
        hasher.combine(endTime)
        hasher.combine(locationName)
        hasher.combine(models)
    }
}
