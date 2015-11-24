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
    //http://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=f14df618ec2fc0c9053638a7d0acd0a8:10:73573488
    func testFetchMovies() {
        let expectation = expectationWithDescription("fetchMovies")
        let movieDataService = MovieDataService()
        movieDataService.fetchMovies(0, success:{ (movies: [Movie]) in
                XCTAssertTrue(movies.count > 0, "movies fetched")
                expectation.fulfill()
            }, failure: {(error: NSError) -> () in
                expectation.fulfill()
        })
        waitForExpectationsWithTimeout(10) { (error: NSError?) -> Void in
            print(">>> timeout of 10 secs triggered")
        }
    }
    
}
