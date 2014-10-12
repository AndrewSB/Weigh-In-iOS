//
//  GameTableViewCell.swift
//  Weigh In
//
//  Created by Andrew Breckenridge on 10/11/14.
//  Copyright (c) 2014 asb. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var percentCompleteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(name: String, image: UIImage, percent: String, date: String) {
        self.gameNameLabel.text = name
        self.gameImageView.image = image
        self.percentCompleteLabel.text = percent
        self.dateLabel.text = date
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
