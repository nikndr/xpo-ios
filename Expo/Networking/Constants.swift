//
//  Constants.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

struct K {
    struct Production {
        static let baseURL = "https://xpo.restful-api.site"
    }
    
    // TODO: - move to each separate API Endpoint/ Maybe as enum
    struct APIParameterKey {
        static let password = "password"
        static let login = "login"
        // TODO
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum ParameterKeys: String, Hashable {
    // MARK: - Auth and User
    case user, login, password, email, name
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
    case expoID = "location_id"
    case organizerID = "organizer_id"
    case visitorID = "visiter_id"
    
    // MARK: - Comment
    case commentID = "comment_id"
    case text
    
    // MARK: - Expo Model
    case modelID
    case arModelURL = "ar_model_url"
    case markerURL = "marker_url"
}
