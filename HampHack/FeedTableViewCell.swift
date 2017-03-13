//
//  FeedTableViewCell.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/3/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var FeedInfo: UILabel!
    @IBOutlet weak var FeedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
