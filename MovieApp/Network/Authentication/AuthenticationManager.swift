//
//  Manager.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/13/19.
//

import Foundation
import Alamofire

class AuthenticationManager {
    
    static func getAPIToken(completionHandler: @escaping (String?, Error?) -> Void) {
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/token/new?api_key=\(Constants.api.api_key.rawValue)", method: .get, success: { res in
            completionHandler((res["request_token"] as! String), nil)
        }) { error in
            completionHandler(nil, (error as! Error))
        }
    }
    
    static func getSessionId(apiToken: String, completionHandler: @escaping (Bool?, String?) -> Void) {
        let parameters = [
            "request_token": apiToken
        ]
        var headers = [requestHeaders]()
        headers.append(requestHeaders(key:"Content-Type",value:"application/json"))
        
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(Constants.api.api_key.rawValue)", method: .post, parameters: parameters, headers: headers, success: { res in
            let sessionID = (res["session_id"] as! String)
            UserDefaults.standard.set(sessionID, forKey: "sessionID")
            completionHandler(true, nil)
        }) { error in
            completionHandler(nil, error["status_message"] as? String ?? "Error")
        }
    }
    
    static func login(userName: String, password: String, requestToken: String, completionHandler: @escaping (String?, String?) -> Void) {
        let parameters = [
            "username": userName,
            "password": password,
            "request_token": requestToken
        ]
        var headers = [requestHeaders]()
        headers.append(requestHeaders(key:"Content-Type",value:"application/json"))
        
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(Constants.api.api_key.rawValue)", method: .post, parameters: parameters, headers: headers, success: { (res) in
            completionHandler((res["request_token"] as! String), nil)
        }) { (error) in
            completionHandler(nil, error["status_message"] as? String ?? "Error")
        }
    }
    
}
