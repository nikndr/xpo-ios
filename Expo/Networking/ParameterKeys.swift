//
//  ParameterKeys.swift
//  Expo
//
//  Created by Nikandr Marhal on 17.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum ParameterKeys: String, Hashable {
    // MARK: - Auth and User

    case user, login, password, email, name, liked
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case superadminRole = "superadmin_role"
    case organizerRole = "organizer_role"
    case userRole = "user_role"
    case userID = "user_id"

    // MARK: - Expo

    case description
    case imageURL = "image_url"
    case startTime = "start_time"
    case endTime = "end_time"
    case locationName = "location_name"
    case expoID = "expo_id"
    case organizerName = "organizer_name"
    case visitorID = "visiter_id"

    // MARK: - Comment

    case commentID = "comment_id"
    case text

    // MARK: - Expo Model

    case modelID
    case arModelURL = "ar_model_url"
    case markerURL = "marker_url"

    // MARK: - Imgur

    case upload
}
