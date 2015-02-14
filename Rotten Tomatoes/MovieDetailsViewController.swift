//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Dhruv Mangtani on 2/8/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDictionary: NSDictionary?
    
   

    @IBOutlet weak var scrollerDescriptionView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var titleDescription:String!
    var synopsisDescription:String!
    var ratingDescription:String!
    var runtimeDescription:Int!
    var backgroundURL:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Dsfa")
        // Do any additional setup after loading the view.
        scrollerDescriptionView.addSubview(synopsisLabel)
        scrollerDescriptionView.contentSize = CGSize(width:10, height:10)
        titleLabel.text = self.titleDescription
        synopsisLabel.text = self.synopsisDescription
        ratingLabel.text = self.ratingDescription
        runtimeLabel.text = "\(self.runtimeDescription/60)hr. \(self.runtimeDescription%60)min."
        backgroundView.setImageWithURL(NSURL(string:backgroundURL))
        //NSLog("%@", titleDescription)
            //NSLog("%@", synopsisDescription)
            //println(titleLabel)
        
           }
        //override func didReceiveMemoryWarning() {
       // super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before 
    //navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }

        */
    
}
