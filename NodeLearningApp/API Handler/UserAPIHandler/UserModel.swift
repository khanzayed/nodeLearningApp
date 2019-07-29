//
//  UserModel.swift
//  NodeLearningApp
//
//  Created by Faraz on 27/07/19.
//  Copyright © 2019 Faraz. All rights reserved.
//




import Foundation
import Alamofire

class UserDataModel: AppDataModel {
    
    var userObj: User?
    
    override init(jsonResponse: DataResponse<Any>) {
        super.init(jsonResponse: jsonResponse)
        
        if errorObject == nil, let response = responseDict {
            userObj = User(details: response)
        }
    }
}

class User {
    
    var id: Int?
    var emailID: String?
    var phoneNumber: String?
    var fName: String?
    var lName: String?
    var fullName: String?
    var authorizationKey: String?
    var isMobileVerify: Bool?
    var isProfileComplete: Bool?
    
    init(details: [String:Any]) {
        id = details["userID"] as? Int
        emailID = details["emailID"] as? String
        phoneNumber = details["phoneNumber"] as? String
        fName = details["firstName"] as? String
        lName = details["lastName"] as? String
        isProfileComplete = details["isProfileComplete"] as? Bool ?? false
    }
    
}
