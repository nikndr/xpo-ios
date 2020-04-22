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
    var arModels: [ARModel]
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

    static func createNewExpo(name: String, description: String, imageURL: String, startTime: Date, endTime: Date, locationName: String, userID: Int, completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.createExpo(name: name, description: description, imageURL: imageURL, startTime: startTime, endTime: endTime, locationName: locationName, userID: userID, completion: completion)
    }

    func updateExpo(name: String?, description: String?, imageURL: String?, startTime: Date?, endTime: Date?, locationName: String, completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.updateExpo(id: id, newName: name, newDescription: description, newImageURL: imageURL, newStartTime: startTime, newEndTime: endTime, newLocationName: locationName, completion: completion)
    }

    static func getExpo(by id: Int, completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.getExpo(id: id, completion: completion)
    }

    func delete(completion: @escaping (Result<Expo, AFError>) -> Void) {
        APIClient.deleteExpo(id: id, completion: completion)
    }
}
