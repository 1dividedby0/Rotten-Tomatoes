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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
        override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
