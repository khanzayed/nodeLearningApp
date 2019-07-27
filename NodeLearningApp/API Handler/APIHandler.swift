 //
//  APIHandler.swift
//  BlueTie
//
//  Created by Faraz Habib on 09/04/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import Foundation
import Alamofire

class APIHandler: NSObject {
    
    internal var baseURL : String {
        get{
            return Environment.shared.getBaseURL()
        }
    }
    
    internal func getHeaders() -> HTTPHeaders {
        var params: [String: String] = [
            "DEVICETYPE"        :   "ios",
//            "versionCode"       :   AppVersion(),
//            "buildVersionCode"  :   AppBuildVersion(),
//            "deviceOSVersion"   :   osVersion(),
//            "osversion"         :   osVersion(),
            "newDeviceType"     :   "2",
            "Content-Type"      :   "application/json"
        ]
        
        if let key = UserDefaults.standard.value(forKey: "authKey") as? String, key.count > 0 {
            params["Authorization"] = key
        }
        
        if let id = UserDefaults.standard.value(forKey: "userID") as? String {
            params["userID"] = id
        }

        return params
    }
    
    internal func getCURLRequest(params:[String:Any]?, method: HTTPMethod) {
        var curlString = "THE CURL REQUEST: \n"
        curlString += "curl -X \(method) \\\n"
        
        getHeaders().forEach{(key, value) in
            let headerKey = self.escapeQuotesInString(str: key)
            let headerValue = self.escapeQuotesInString(str: value)
            curlString += " -H \'\(headerKey): \(headerValue)\' \n"
        }
        
        curlString += " \(baseURL) \\\n"
        
        if let body = params {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    let bodyDataString = self.escapeQuotesInString(str: str)
                    curlString += " -d \'\(bodyDataString)\'"
                }
            } catch _ {
                print("cURL Params Parsing Exception")
            }
        }
        
        print(curlString)
    }
    
    internal func getCURLRequest(url:String, params:[String:Any]?, method: HTTPMethod) {
        var curlString = "THE CURL REQUEST:\n"
        curlString += "curl -X \(method) \\\n"
        
        getHeaders().forEach{(key, value) in
            let headerKey = self.escapeQuotesInString(str: key)
            let headerValue = self.escapeQuotesInString(str: value)
            curlString += " -H \'\(headerKey): \(headerValue)\' \n"
        }
        
        curlString += " \(url) \\\n"
        
        if let body = params {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    let bodyDataString = self.escapeQuotesInString(str: str)
                    curlString += " -d \'\(bodyDataString)\'"
                }
            } catch _ {
                print("cURL Params Parsing Exception")
            }
        }
        
        print(curlString)
    }
    
    private func escapeQuotesInString(str:String) -> String {
        return str.replacingOccurrences(of: "\\", with: "")
    }
}

extension APIHandler : URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("\n")
        print("\n")
        print("Authentication Challenge")
        print("\n")
        print("\n")
    }
    
 }
