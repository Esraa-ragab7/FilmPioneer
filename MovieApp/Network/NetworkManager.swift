//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/14/19.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    // MARK: - Properties
    
    let reachabilityManager:NetworkReachabilityManager?
    
    static let sharedInstance = NetworkManager()
    
    // MARK: - Initialization
    
    private override init() {
        
        reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    }
    
    // MARK: - Accessors
    
    func isConnected() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    func isConnected3G() -> Bool {
        return reachabilityManager?.isReachableOnWWAN ?? false
    }
    
    func serverRequests(url :String,
                        method :HTTPMethod = .get,
                        parameters:[String:Any] = [:],
                        headers : [requestHeaders] = [],
                        arrayParameter: [[String:Any]] = [],
                        success:@escaping ([String:Any]) -> Void,
                        failure:@escaping ([String:Any]) -> Void ) {
        
        let RequestURL = URL(string: url)
        var request = URLRequest(url: RequestURL!)
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if parameters.count > 0{
            let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = httpBody
        } else if arrayParameter.count > 0 {
            let httpBody = try? JSONSerialization.data(withJSONObject: arrayParameter, options: [])
            request.httpBody = httpBody
        }
        
        Alamofire.request(request).responseData{ response in
//            print(response.response?.statusCode)
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do {
                    let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    if let respoDict = readableJson as? [String:Any] {
                        print(respoDict)
                        success(respoDict)
                    }
                    else{
                        success(["msg":"success"])
                    }
                }catch {
                    do {
                        let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                        if let respoDict = readableJson as? [String:Any] {
                            print(respoDict)
                            failure(respoDict)
                        }
                    }catch {
                        success(["successMsg":"done"])
                    }
                }
            }else{
                do {
                    let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    if let respoDict = readableJson as? [String:Any] {
                        print(respoDict)
                        failure(respoDict)
                    }
                }catch {
                    failure(["msg":"Time Out"])
                }
            }
        }
    }
    
}

struct requestHeaders{
    var key = String()
    var value = String()
}
