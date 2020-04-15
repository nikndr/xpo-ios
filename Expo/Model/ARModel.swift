//
//  ARModel.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct ARModel: Identifiable {
    // MARK: - Model properties

    let id: Int
    let markerURL: String
    let modelURL: String
    let expoID: Int
    let createdAt: Date
    let updatedAt: Date

    // MARK: - Other properties

    var markerFilePath: String?
    var modelFilePath: String?
}

extension ARModel: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case markerURL = "marker_url"
        case modelURL = "ar_model_url"
        case expoID = "expo_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.markerURL = try container.decode(String.self, forKey: .markerURL)
        self.modelURL = try container.decode(String.self, forKey: .modelURL)
        self.expoID = try container.decode(Int.self, forKey: .expoID)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}

extension ARModel: Hashable, Equatable {
    static func ==(lhs: ARModel, rhs: ARModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
