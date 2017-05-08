//
//  DoneAndPostponedActivitiesTableViewCell.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 06/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class DoneAndPostponedActivitiesTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
