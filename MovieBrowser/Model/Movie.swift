//
//  Movie.swift
//  MovieBrowser
//
//  Created by Madhu Samuel on 24/11/2015.
//  Copyright © 2015 Madhu. All rights reserved.
//

import Foundation

class Movie: Mappable {
    
    var id: Int?
    var name: String?
    var capsuleReview: String?
    
    class func newInstance() -> Mappable {
        return Movie()
    }
    
    func mapping(map: Map) {
        id <- map["nyt_movie_id"]
        name <- map["display_title"]
        capsuleReview <- map["capsule_review"]
    }
}
