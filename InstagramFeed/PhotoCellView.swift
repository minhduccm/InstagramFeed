//
//  PhotoCellView.swift
//  InstagramFeed
//
//  Created by Duc Dinh on 10/12/16.
//  Copyright © 2016 Duc Dinh. All rights reserved.
//

import UIKit

class PhotoCellView: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
