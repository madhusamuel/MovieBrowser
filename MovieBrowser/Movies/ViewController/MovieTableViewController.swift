//
//  MovieTableViewController.swift
//  MovieBrowser
//
//  Created by Madhu Samuel on 24/11/2015.
//  Copyright © 2015 Madhu. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movies: [Movie] = []
    let movieDataService = MovieDataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    var currentOffset = 0
    func fetchMovies() {
        //TODO manage indicator - whats the industry standard?
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        movieDataService.fetchMovies(currentOffset, success: { (movies) -> () in
                self.movies += movies
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }) { (error) -> () in
                print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell") as! MovieTableViewCell
        print("row -> \(indexPath.row)")
        let movie = movies[indexPath.row]
        cell.movieTitle.text = movie.name
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
