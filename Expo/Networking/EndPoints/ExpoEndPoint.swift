//
//  ExpoRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum ExpoEndPoint {
    // MARK: - Endpoints

    case getAllExpos(organizerID: Int?, visitorID: Int?)
    case getExpo(id: Int)
    case createExpo(name: String, description: String, imageURL: String, startTime: Date, endTime: Date, locationName: String, userID: Int)
    case updateExpo(id: Int,
                    newName: String?,
                    newDescription: String?,
                    newImageURL: String?,
                    newStartTime: Date?,
                    newEndTime: Date?,
                    newLocationName: String?)
    case deleteExpo(id: Int)
}

// MARK: - EndPointType

extension ExpoEndPoint: EndPointType {
    var method: HTTPMethod {
        switch self {
        case .getExpo, .getAllExpos:
            return .get
        case .createExpo:
            return .post
        case .updateExpo:
            return .put
        case .deleteExpo:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .getAllExpos, .createExpo:
            return "/expos"
        case .getExpo(let id), .updateExpo(let id, _, _, _, _, _, _), .deleteExpo(let id):
            return "/expos/\(id)"
        }
    }

    var task: HTTPTask {
        switch self {
        case .getAllExpos(let organizerID, let visitorID):
            let parameters: OptionalParameters = [.organizerID: organizerID,
                                                  .visitorID: visitorID]
            return .requestWithParametersAndAuth(bodyParameters: nil,
                                          urlParameters: URLParameterEncoder.coalesce(parameters))
        case .getExpo:
            return .requestWithAuth
        case .createExpo(let name, let description, let imageURL, let startTime, let endTime, let locationName, let userID):
            return .requestWithParametersAndAuth(bodyParameters: [.name: name,
                                                           .description: description,
                                                           .imageURL: imageURL,
                                                           .startTime: startTime,
                                                           .endTime: endTime,
                                                           .locationName: locationName,
                                                           .userID: userID],
                                          urlParameters: nil)
        case .updateExpo(_, let newName, let newDescription, let newImageURL, let newStartTime, let newEndTime, let newLocationName):
            let parameters: OptionalParameters = [.name: newName,
                                                  .description: newDescription,
                                                  .imageURL: newImageURL,
                                                  .startTime: newStartTime,
                                                  .endTime: newEndTime,
                                                  .locationName: newLocationName]
            return .requestWithParametersAndAuth(bodyParameters: JSONParameterEncoder.coalesce(parameters),
                                          urlParameters: nil)
        case .deleteExpo:
            return .requestWithAuth
        }
    }
}