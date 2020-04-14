//
//  ExpoModelRouter.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum ExpoModelEndPoint {
    // MARK: - Endpoints

    case getAllExpoModels(expoID: String?)
    case getExpoModel(modelID: Int)
    case createExpoModel(expoID: Int, arModelURL: String, markerURL: String)
    case updateExpoModel(modelID: Int, arModelURL: String?, markerURL: String?)
    case deleteExpoModel(modelID: Int)
}

// MARK: - EndPointType

extension ExpoModelEndPoint: EndPointType {
    var method: HTTPMethod {
        switch self {
        case .getAllExpoModels, .getExpoModel:
            return .get
        case .createExpoModel:
            return .post
        case .updateExpoModel:
            return .put
        case .deleteExpoModel:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .getAllExpoModels, .createExpoModel:
            return "/expo_models"
        case .getExpoModel(let modelID), .updateExpoModel(let modelID, _, _), .deleteExpoModel(let modelID):
            return "/expo_models/\(modelID)"
        }
    }

    var task: HTTPTask {
        switch self {
        case .getExpoModel, .deleteExpoModel:
            return .request
        case .getAllExpoModels(let expoID):
            let parameters: OptionalParameters = [.expoID: expoID]
            return .requestWithParameters(bodyParameters: nil,
                                          urlParameters: URLParameterEncoder.coalesce(parameters))
        case .createExpoModel(let expoID, let arModelURL, let markerURL):
            return .requestWithParameters(bodyParameters: [.expoID: expoID,
                                                           .arModelURL: arModelURL,
                                                           .markerURL: markerURL],
                                          urlParameters: nil)
        case .updateExpoModel(let modelID, let arModelURL, let markerURL):
            let parameters: OptionalParameters = [.modelID: modelID,
                                                  .arModelURL: arModelURL,
                                                  .markerURL: markerURL]
            return .requestWithParameters(bodyParameters: JSONParameterEncoder.coalesce(parameters),
                                          urlParameters: nil)
        }
    }
}
