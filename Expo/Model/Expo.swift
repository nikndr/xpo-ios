//
//  Expo.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire
import Foundation

struct Expo: Identifiable, Codable {
    // MARK: - Properties

    let id: Int
    let userID: Int
    let name: String
    let description: String
    let imageURL: String
    let startTime: Date
    let endTime: Date
    let locationName: String
    let likesCount: Int
    let viewsCount: Int
    let createdAt: Date
    let updatedAt: Date
    let organizerName: String
    let arModels: [ARModel]
    var comments: [Comment]

    // MARK: - Maintaining expo load state

    var downloaded = false

    // MARK: - AR Model loading

    func downloadContents() {}

    // MARK: - Conformation to Codable

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
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
        case organizerName = "organizer_name"
        case comments
        case arModels = "expo_models"
    }

//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.userID = try container.decode(Int.self, forKey: .userID)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.imageURL = try container.decode(String.self, forKey: .imageURL)
//        self.startTime = try container.decode(Date.self, forKey: .startTime)
//        self.endTime = try container.decode(Date.self, forKey: .endTime)
//        self.locationName = try container.decode(String.self, forKey: .locationName)
//        self.likesCount = try container.decode(Int.self, forKey: .likesCount)
//        self.viewsCount = try container.decode(Int.self, forKey: .viewsCount)
//        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
//        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
//        self.organizerName = try container.decode(String.self, forKey: .organizerName)
//
//        let commentContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .comments)
//        self.comments = try commentContainer.decode([Comment].self, forKey: .comments)
//
//        let modelContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .arModels)
//        self.arModels = try modelContainer.decode([ARModel].self, forKey: .arModels)
//    }
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

    static func getExpo(by id: Int, completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.getExpo(id: id, completion: completion)
    }

    func delete(completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.deleteExpo(id: id, completion: completion)
    }
}
