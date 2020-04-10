//
//  ARModel.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct ARModel: Identifiable {
    var id: Int
    var markerURL: String
    var modelURL: String

    init(id: Int, markerURL: String, modelURL: String) {
        self.id = id
        self.markerURL = markerURL
        self.modelURL = modelURL
    }

    init(markerURL: String, modelURL: String) {
        self.id = ARModel.nextID
        self.markerURL = markerURL
        self.modelURL = modelURL
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

// MARK: - Database xDxDxD

extension ARModel {
    static var nextID: Int {
        models.count
    }

    static var models: [ARModel] = [
        ARModel(id: 0, markerURL: "", modelURL: ""),
        ARModel(id: 1, markerURL: "", modelURL: ""),
        ARModel(id: 2, markerURL: "", modelURL: ""),
        ARModel(id: 3, markerURL: "", modelURL: ""),
    ]
}
