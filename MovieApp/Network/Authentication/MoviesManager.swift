//
//  MoviesManager.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/18/19.
//

import Foundation
import Alamofire

class MoviesManager {
    
    static func getTopRatedMovies(pageNum: String, completionHandler: @escaping ([String:Any]?, [String:Any]?) -> Void) {
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(Constants.api.api_key.rawValue)&language=en-US&page=\(pageNum)", success: { (res) in
            completionHandler(res, nil)
        }) { (error) in
            completionHandler(nil, error)
        }
    }
    
}

