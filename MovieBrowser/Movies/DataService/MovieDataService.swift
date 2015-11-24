//
//  MovieDataService.swift
//  MovieBrowser
//
//  Created by Madhu Samuel on 24/11/2015.
//  Copyright © 2015 Madhu. All rights reserved.
//

import Foundation

class MovieDataService {
    
    //http://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=f14df618ec2fc0c9053638a7d0acd0a8:10:73573488
    func fetchMovies(offset: Int, success: (movies: [Movie]) -> (), failure: (error: NSError) -> ()) {
        let url = "http://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=f14df618ec2fc0c9053638a7d0acd0a8:10:73573488"+"&offset="+String(offset)
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
//                    print(json)
                    print("results ---> \(json["num_results"])")
                    
                    guard let results = json["results"] as? [Dictionary<String, AnyObject>] else {
                        dispatch_async(dispatch_get_main_queue(), {
                            success(movies:[])
                        })
                        
                        return
                    }
                    let movies = results.map {(result) -> Movie in
                        return Mapper().map(result, toObject: Movie())
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        success(movies: movies)
                    })
                } catch let JSONError as NSError {
                    //json parsing error
                    failure(error: JSONError)
                }
            } else {
                //possible network error
                failure(error: error!)
            }
        }
        
        task.resume()
    }
    
}
