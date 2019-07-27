//
//  AppDataModel.swift
//  BlueTie
//
//  Created by Faraz Habib on 09/04/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import Foundation
import Alamofire

class AppDataModel {
    
    var errorObject: APIErrorModel?
    var responseDict: [String: Any]?
    var responseDictArr: [[String: Any]]?
    var responseArr: [String]?
    var responseString: String?
    var status: Int!
    var statusEnum : ResponseStatus!
    var message: String!
    
    init(jsonResponse: DataResponse<Any>) {
        print("\n")
        print("RESPONSE --> \(jsonResponse)")
        print("\n")

        if let error = jsonResponse.error {
            status = 0
            statusEnum = ResponseStatus(rawValue: status)
            
            switch error.code {
            case NSURLErrorTimedOut:
                errorObject = APIErrorModel(code: -1100, message: "Request timed out. Please try again later.")
            default:
                errorObject = APIErrorModel(code: -1101, message: "An error occured. Please try again later.")
            }
            return
        }
        
        guard let response = jsonResponse.result.value as? [String: Any] else {
           return
        }
   
        status = response["STATUS"] as? Int ?? 0
        statusEnum = ResponseStatus(rawValue: status)
        
        if status == 1002 {
            
        }
        
        if status == 1001 || status == 1022 { // Success
            
            if let dict = response["RESULT"] as? [String: Any] {
                responseDict = dict
            }
           
            
            if let dictArr = response["RESULT"] as? [[String: Any]]{
                responseDictArr = dictArr
            }
            
            else if let dict = response["SUBSCRIPTIONPLANDETAILS"] as? [String:Any] {
                responseDict = dict
            }
                
            if let dict = response["RESULT"] as? [String: Any] , let responseData = dict["userDetails"] as? [String:Any] {
                responseDict = responseData
            }
            
            if let messageString = response["MESSAGE"] as? String {
                message = messageString
            }
            
            if let str = response["NOTIFICATIONTITLE"] as? String {
                responseString = str
            } else if let dict = response["RESULT"] as? [String: Any] , let notificationTitle = dict["notificationTitle"] as? String {
                responseString = notificationTitle
            }
            
        } else {
            if let arr = response["RESULT"] as? [String] {
                responseArr = arr
            }
            
            if let message = response["MESSAGE"] as? String {
            errorObject = APIErrorModel(code: response["STATUS"] as? Int ?? 0, message: message)
            } else if let error = response["ERROR"] as? [[String : Any]] , error.count > 0{
                if let message = error[0]["msg"] as? String {
                    errorObject = APIErrorModel(code: response["STATUS"] as? Int ?? 0, message: message)
                }else if let message = error[0]["msg"] as? [[String:Any]], let msg = message[0]["msg"] as? String {
                    errorObject = APIErrorModel(code: response["STATUS"] as? Int ?? 0, message: msg)
                }
                
            }else {
               errorObject = APIErrorModel(code: response["STATUS"] as? Int ?? 0, message: message)
            }
        }
    }
}

struct APIErrorModel {
    
    var code: Int!
    var message: String?
    
    init(code: Int, message: String?) {
        self.code = code
        self.message = message
    }
}



extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}


