//
//  Router.swift
//  Expo
//
//  Created by Nikandr Marhal on 13.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

// Router : to be or not to be
// Implement Generic Router to store AF request as property (with ability to cancel)
// as well as different request methods with different callbacks (responseDecodable, responseData)

class Router<EndPoint: EndPointType>: NetworkRouter {
    var dataRequest: DataRequest?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {}

    func cancel() {
        dataRequest?.cancel()
    }
}
