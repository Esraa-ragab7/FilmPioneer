//
//  AccountManager.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/18/19.
//

import Foundation
import Alamofire

class AccountManager {
    
    static func logOut(completionHandler: @escaping (Bool?, String?) -> Void) {
        let parameters = [
            "session_id": UserDefaults.standard.string(forKey: "sessionID")
        ]
        var headers = [requestHeaders]()
        headers.append(requestHeaders(key:"Content-Type",value:"application/json"))
        
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/session?api_key=\(Constants.api.api_key.rawValue)", method: .delete, parameters: parameters as [String : Any], headers: headers, success: { (res) in
            completionHandler(true, nil)
        }) { error in
            completionHandler(nil, error["status_message"] as? String ?? "Error")
        }
    }
    
    static func getProfile(completionHandler: @escaping ([String:Any]?, [String:Any]?) -> Void) {
        let session_id = UserDefaults.standard.string(forKey: "sessionID")
        
         NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/account?api_key=\(Constants.api.api_key.rawValue)&session_id=\(session_id ?? "")", success: { (res) in
            completionHandler(res, nil)
        }) { error in
            completionHandler(nil, error)
        }
    }
    
}

