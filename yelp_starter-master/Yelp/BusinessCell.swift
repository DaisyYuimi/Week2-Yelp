//
//  BusinessCell.swift
//  Yelp
//
//  Created by sophie on 7/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit


class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            if let imageURL = business.imageURL {
            thumbImageView.setImageWithURL(imageURL)
            }
            distanceLabel.text = business.distance
            ratingImageView.setImageWithURL(business.ratingImageURL!)
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
