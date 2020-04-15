//
//  APIClient.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

struct APIClient {
    // MARK: - Generic requests

    
    @discardableResult
    private static func request<ResponseType: Decodable>(route: EndPointType,
                                                         decoder: JSONDecoder = JSONDecoder(),
                                                         completion: @escaping (Result<ResponseType, AFError>) -> Void) -> DataRequest {
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        return AF.request(route)
            .validate(statusCode: 200..<600)
            .responseDecodable(decoder: decoder) { (response: DataResponse<ResponseType, AFError>) in
                debugPrint(response)
                if let auth = response.response?.allHeaderFields["Authorization"] as? String {
                    UserDefaults.standard.setValue(value: auth, forKey: .jwt)
                }
                completion(response.result)
            }
    }
    
    // MARK: - Auth
    
    static func login(login: String, password: String, completion: @escaping (Result<User, AFError>) -> Void) {
        request(route: AuthEndPoint.login(login: login, password: password),
                completion: completion)
    }
    
    static func signUp(name: String,
                       username: String,
                       password: String,
                       isOrganizer: Bool,
                       email: String,
                       completion: @escaping (Result<User, AFError>) -> Void) {
        request(route: AuthEndPoint.signup(login: username, email: email, password: password, name: name, isOrganizer: isOrganizer),
                completion: completion)
    }
    
    // MARK: - User
    
    static func updateUser(login: String, newLogin: String?, newName: String?, newPassword: String?, completion: @escaping (Result<User, AFError>) -> Void) {
        request(route: UserEndPoint.updateUser(login: login, newLogin: newLogin, newName: newName, newPassword: newPassword),
                completion: completion)
    }
    
    static func getAllUsers(completion: @escaping (Result<User, AFError>) -> Void) {
        request(route: UserEndPoint.getAllUsers, completion: completion)
    }
    
    static func getUser(login: String, completion: @escaping (Result<User, AFError>) -> Void) {
        request(route: UserEndPoint.getUser(login: login), completion: completion)
    }
    
    static func like(userID: Int, expoID: Int, value: Bool, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        print(value)
        request(route: UserEndPoint.like(userID: userID, expoID: expoID, value: value), completion: completion)
    }
    
    static func visit(userID: Int, expoID: Int, completion: @escaping (Result<UserToExpo, AFError>) -> Void) {
        request(route: UserEndPoint.visit(userID: userID, expoID: expoID), completion: completion)
    }
    
    // MARK: - Expo
    
    static func getAllExpos(completion: @escaping (Result<[Expo], AFError>) -> Void) {
        request(route: ExpoEndPoint.getAllExpos, completion: completion)
    }
    
    static func getExpo(id: Int, completion: @escaping (Result<Expo, AFError>) -> Void) {
        request(route: ExpoEndPoint.getExpo(id: id), completion: completion)
    }
    
    static func createExpo(name: String,
                           description: String,
                           imageURL: String,
                           startTime: Date,
                           endTime: Date,
                           locationName: String,
                           userID: Int,
                           completion: @escaping (Result<Expo, AFError>) -> Void) {
        request(route: ExpoEndPoint.createExpo(name: name,
                                               description: description,
                                               imageURL: imageURL,
                                               startTime: startTime,
                                               endTime: endTime,
                                               locationName: locationName,
                                               userID: userID),
                completion: completion)
    }
    
    static func updateExpo(id: Int,
                           newName: String?,
                           newDescription: String?,
                           newImageURL: String?,
                           newStartTime: Date?,
                           newEndTime: Date?,
                           newLocationName: String?,
                           completion: @escaping (Result<Expo, AFError>) -> Void) {
        request(route: ExpoEndPoint.updateExpo(id: id,
                                               newName: newName,
                                               newDescription: newDescription,
                                               newImageURL: newImageURL,
                                               newStartTime: newStartTime,
                                               newEndTime: newEndTime,
                                               newLocationName: newLocationName),
                completion: completion)
    }
    
    static func deleteExpo(id: Int, completion: @escaping (Result<Expo, AFError>) -> Void) {
        request(route: ExpoEndPoint.deleteExpo(id: id), completion: completion)
    }
    
    // MARK: - Expo Model
    
    // MARK: - Comments
    
    static func getAllComments(userID: Int?, expoID: Int, completion: @escaping (Result<Comment, AFError>) -> Void) {
        request(route: CommentsEndPoint.getAllComments, completion: completion)
    }
    
    static func getComment(commentID: Int, completion: @escaping (Result<Comment, AFError>) -> Void) {
        // TODO: impl
    }
    
    static func createComment(userID: Int, expoID: Int, text: String, completion: @escaping (Result<Comment, AFError>) -> Void) {
        request(route: CommentsEndPoint.createComment(userID: userID, expoID: expoID, text: text), completion: completion)
    }
    
    static func updateComment(commentID: Int, text: String, completion: @escaping (Result<Comment, AFError>) -> Void) {
        // TODO: impl
    }
    
    static func deleteComment(commentID: Int, completion: @escaping (Result<Comment, AFError>) -> Void) {
        request(route: CommentsEndPoint.deleteComment(commentID: commentID), completion: completion)
    }
}
