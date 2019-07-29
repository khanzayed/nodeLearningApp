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
    var status: Int!
    var message: String!
    
    init(jsonResponse: DataResponse<Any>) {
        print("\n")
        print("RESPONSE --> \(jsonResponse)")
        print("\n")

        guard let response = jsonResponse.result.value as? [String: Any] else {
           return
        }
   
        status = response["status"] as? Int ?? 0
        if let dict = response["result"] as? [String: Any] {
            responseDict = dict
        } else if let dictArr = response["result"] as? [[String: Any]]{
            responseDictArr = dictArr
        }
        
        if let messageString = response["message"] as? String {
            message = messageString
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


