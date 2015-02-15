//
//  MovieTableViewCell.swift
//  Rotten Tomatoes
//
//  Created by Dhruv Mangtani on 2/7/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var imageLink:String!
    var loading:Bool!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loader.startAnimating()
        if posterImage.image != nil && posterImage.image == imageLink{
            loader.stopAnimating()
        }
    }
    
        override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
