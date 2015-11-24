//
//  MovieDataServiceTests.swift
//  MovieBrowser
//
//  Created by Madhu Samuel on 24/11/2015.
//  Copyright © 2015 Madhu. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class MovieDataServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchMoviesForOffset(offset: Int) {
        let movieDataService = MovieDataService()
        movieDataService.fetchMovies(0, success:{ (movies: [Movie]) in
            }, failure: {(error: NSError) -> () in
        })
    }
    
}
