//
//  UserAPIHandler.swift
//  NodeLearningApp
//
//  Created by Faraz on 27/07/19.
//  Copyright © 2019 Faraz. All rights reserved.
//

import Foundation
import Alamofire

class UserDetailsAPIHandler: APIHandler {
    
    var alamofireManager : SessionManager!
    
    override init() {
        alamofireManager = Alamofire.SessionManager.default
        alamofireManager.session.configuration.timeoutIntervalForResource = 10
        alamofireManager.session.configuration.timeoutIntervalForRequest = 10
    }
    
    func loginWithNode(_ params: [String: Any], completion:  @escaping (UserDataModel) -> Void) {
        let url = baseURL + "/v3/socialSignIn"
        
        super.getCURLRequest(url: url, params: params, method: .post)
        alamofireManager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: super.getHeaders()).responseJSON { (response) in
            let userDataModel = UserDataModel(jsonResponse: response)
            completion(userDataModel)
        }
    }
    
}
