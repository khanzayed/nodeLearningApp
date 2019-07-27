//
//  Environments.swift
//  BlueTie
//
//  Created by admin on 21/08/18.
//  Copyright © 2018 BlueTie. All rights reserved.
//

import Foundation


final class Environment {
    
    private var baseUrl : String
    private var appID : String
    private var debugging = false
    
    //MARK: Google
    private var googleClientID : String
    private var googleAPIKey : String
    
    private struct Static {
        static let instance = Environment()
    }
    
    internal static var shared:Environment {
        get {
            return Static.instance
        }
    }
    
    private init() {
        let targetName = Bundle.main.infoDictionary!["Target Name"] as! String
        let environmentListPath = Bundle.main.path(forResource: "Environment", ofType: "plist")
        let environmentList = NSDictionary(contentsOfFile:environmentListPath!) as! [String:Any]
        let environment = environmentList[targetName] as! [String:Any]
        debugging = environment["kIsDebugging"] as! Bool
        baseUrl = environment["kBaseUrl"] as! String
        googleClientID = environment["kGoogleClientID"] as! String
        googleAPIKey = environment["kGoogleAPIKey"] as! String
        appID = environment["kAppID"] as! String
    }
    
    internal func getBaseURL() -> String {
        return baseUrl
    }
    
    internal func isDebugging() -> Bool {
        return debugging
    }
    
    internal func getGoogleClientID() -> String {
        return googleClientID
    }
    
    internal func getGoogleAPIKey() -> String {
        return googleAPIKey
    }
    
    internal func getAppID() -> String {
        return appID
    }
    
}

