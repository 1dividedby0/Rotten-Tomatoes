//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Dhruv Mangtani on 2/7/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UITableViewController {
    
    var moviesArray: NSArray?
    var ratingsArray: NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        var refreshControl = UIRefreshControl()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
           // self.refreshControl.endRefreshing()
        })
    }
    override func viewDidAppear(animated:Bool){
        super.viewDidAppear(animated)
        
        
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=rmvva9sq5s2tc2amv6db859f"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        if(isConnectedToNetwork()){
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
           let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:
                &errorValue) as NSDictionary
            self.moviesArray = dictionary["movies"] as? NSArray
            self.tableView.reloadData()
            
        })
        }
        else{
            println("NO WIFI")
            var networkLabel = UILabel()
            networkLabel.text = "No Network Connection"
            //self.addSubView
        }
    }
        func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray{
            return array.count
        }
        else{
            return 0
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("com.dhruv.mycell") as MovieTableViewCell

        cell.movieTitleLabel.text = movie["title"] as NSString
        var rating = movie["mpaa_rating"] as NSString
        var synopsis = movie["synopsis"] as NSString
        cell.movieSynopsis.text = "\(rating) \(synopsis)"
        var link = movie["posters"]!["thumbnail"] as String
        let range = Range(start: link.startIndex, end: advance(link.startIndex, 53))
        cell.posterImage.setImageWithURL(NSURL(string: link.substringWithRange(range) + "ori.jpg"))
//        var posterImage:UIImage = UIImage(named: link)!

        println(link)
//        var image = UIImage(CGImage: link)
//        cell.posterImage.image = image
        //var posters:NSArray = movie["posters"] as NSArray
        //cell.movieSynopsis.text = movie["synopsis"] as NSString

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let details = mainStoryboard.instantiateViewControllerWithIdentifier("movieDetailViewController") as MovieDetailsViewController

        //let details = MovieDetailsViewController(nibName: "movieDetailViewController", bundle:nil)
//        details.titleDescription = "dsf"
//        details.synopsisDescription = "asdfads"
    
       //details.updateLabel()
        //details.reloadInputViews()
        
//        let movie = self.moviesArray![indexPath.row] as NSDictionary
//        details.titleDescription = movie["title"] as NSString
//        details.synopsisDescription = movie["synopsis"] as NSString
//    
//        let cell = tableView.dequeueReusableCellWithIdentifier("com.dhruv.mycell") as MovieTableViewCell
//        details.titleDescription = cell.movieTitleLabel.text
//        println(details.titleDescription)
//        details.synopsisDescription = "asdfads"
        //details.synopsisDescription = cell.movieSynopsis.text
        //details.synopsisLabel.reloadInputViews()
        //details.lod()
        //self.navigationController?.pushViewController(details, animated:true)
//        details.titleLabel.text = movie["title"] as NSString
//        details.synopsisLabel.text = movie["synopsis"] as NSString

    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "movieDetailSegue") {
            let details:MovieDetailsViewController = segue.destinationViewController as MovieDetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let movie = self.moviesArray![indexPath!.row] as NSDictionary
            let title = movie["title"] as NSString
            let rating = movie["mpaa_rating"] as NSString
            let runtime = movie["runtime"] as NSInteger
            let year = movie["year"] as NSNumber
            let image = movie["posters"]!["thumbnail"] as String
            details.titleDescription = "\(title) (\(year))"
            details.synopsisDescription = movie["synopsis"] as NSString
            details.ratingDescription = rating
            details.runtimeDescription = runtime
            println(year)
            let a = image.componentsSeparatedByString("_")
            let b:String = a[1] as NSString
            let c:Array = b.componentsSeparatedByString(".")
            let range = Range(start: image.startIndex, end: advance(image.startIndex, 53))
            details.backgroundURL = image.substringWithRange(range) + "ori.jpg"
            println(details.backgroundURL)
            //println("sdfskdjfnsjdifjsidjflsdfksndflnsjdfnjk\(details.backgroundURL)")
            //details.backgroundView.setImageWithURL(NSURL(string:image))
        }
    }
}

