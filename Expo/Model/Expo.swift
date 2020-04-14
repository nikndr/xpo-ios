//
//  Expo.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire
import Foundation

class Expo: Identifiable, Codable {
    // MARK: - Properties

    var id: Int
    var organizerID: Int
    var name: String
    var description: String
    var imageURL: String
    var startTime: Date
    var endTime: Date
    var locationName: String
    var likesCount = Int()
    var viewsCount = Int()
    let createdAt: Date
    var updatedAt: Date

    // MARK: - Maintaining expo load state

    var downloaded = false

    // MARK: - User interaction logic

    func increaseViewCount() {}

    func increaseLikeCount() {}

    func decreaseLikeCount() {}

    // MARK: - AR Model loading

    func downloadContents() {}

    // MARK: - Conformation to Codable

    enum ExpoCodingKeys: String, CodingKey {
        case id
        case organizerID = "user_id"
        case name
        case description
        case imageURL = "image_url"
        case startTime = "start_time"
        case endTime = "end_time"
        case locationName = "location_name"
        case likesCount = "likes_count"
        case viewsCount = "views_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExpoCodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.organizerID = try container.decode(Int.self, forKey: .organizerID)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.startTime = try container.decode(Date.self, forKey: .startTime)
        self.endTime = try container.decode(Date.self, forKey: .endTime)
        self.locationName = try container.decode(String.self, forKey: .locationName)
        self.likesCount = try container.decode(Int.self, forKey: .likesCount)
        self.viewsCount = try container.decode(Int.self, forKey: .viewsCount)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
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

// MARK: - Accessing remote data

extension Expo {
    static func getAllExpos(completion: @escaping (Result<[Expo], AFError>) -> Void) {
        APIClient.getAllExpos(completion: completion)
    }

    func getOrganizer(completion: @escaping (Result<User, AFError>) -> Void) {
        // TODO: API FIX
    }
    
    func випіліца(completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.deleteExpo(id: id, completion: completion)
    }
}
