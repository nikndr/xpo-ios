//
//  Expo.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

class Expo: Identifiable {
    // MARK: - Maintaining expo load state

    var downloaded = false

    // MARK: - Properties

    var id: Int
    var organizer: User
    var name: String
    var description: String
    var imageURL: URL
    var startTime: Date
    var endTime: Date
    var locationName: String
    var viewsCount = Int()
    var likesCount = Int()
    var models: [ARModel]

    // MARK: - User interaction logic

    func increaseViewCount() {
        viewsCount += 1
    }

    func increaseLikeCount() {
        likesCount += 1
    }
    
    func decreaseLikeCount() {
        likesCount -= 1
    }

    // MARK: - AR Model loading

    func downloadContents() {}

    // MARK: - Initialization

    init(id: Int, organizer: User, name: String, description: String, imageURL: URL, startTime: Date, endTime: Date, locationName: String, models: [ARModel]) {
        self.id = id
        self.organizer = organizer
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.startTime = startTime
        self.endTime = endTime
        self.locationName = locationName
        self.models = models
    }

    init(organizer: User, name: String, description: String, imageURL: URL, startTime: Date, endTime: Date, locationName: String, models: [ARModel]) {
        self.id = Expo.nextID
        self.organizer = organizer
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.startTime = startTime
        self.endTime = endTime
        self.locationName = locationName
        self.models = models
    }
}

// MARK: - Conformation to Hashable, Equtable

extension Expo: Hashable, Equatable {
    static func ==(lhs: Expo, rhs: Expo) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Database xDxDxDxD

extension Expo {
    static var nextID: Int {
        expos.count
    }

    static var expos: [Expo] = [
        Expo(id: 0, organizer: User.users[1], name: "Expo 1", description: "Very good expo", imageURL: URL(string: "https://nova.lc/wp-content/uploads/2020/01/dubai-.jpg")!, startTime: Date(), endTime: Date(), locationName: "Apple Park", models: ARModel.models),
        Expo(id: 1, organizer: User.users[2], name: "Expo 2", description: "Very good expo, but another", imageURL: URL(string: "https://i.imgur.com/qcVM19M.jpg")!, startTime: Date(), endTime: Date(), locationName: "Kyiv", models: ARModel.models),
        Expo(id: 2, organizer: User.users[1], name: "Expo 3", description: "Please don't visit this expo", imageURL: URL(string: "https://i.imgur.com/lBizl0j.jpg")!, startTime: Date(), endTime: Date(), locationName: "Cherkasy", models: ARModel.models),
    ]

    static func add(_ expo: Expo) {
        expos += [expo]
    }
}
