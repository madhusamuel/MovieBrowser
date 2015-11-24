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
    }
    
    var currentOffset = 0
    //invoked from cellforrow at indexpath
    func fetchMovies() {
        print("fetchMovies() - offset \(currentOffset)")
        //TODO manage indicator - whats the industry standard?
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.movieDataService.fetchMovies(self.currentOffset, success: { (movies) -> () in
                self.movies += movies
                self.tableView.reloadData()
                self.currentOffset += 20
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }) { (error) -> () in
                    print(error)
            }
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("row -> \(indexPath.row)")
        if indexPath.row < movies.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell") as! MovieTableViewCell
            let movie = movies[indexPath.row]
            cell.movieTitle.text = movie.name
            return cell
        } else {
            print("Loading cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("LoadingTableViewCell") as! LoadingTableViewCell
            cell.titleLabel.text = "Loading Movies \(currentOffset) to \(currentOffset + 20)..."
            fetchMovies()
            return cell
        }
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
