//
//  ActivityTableViewCell.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 03/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activitySubject: UILabel!
    @IBOutlet weak var activityHour: UILabel!
    @IBOutlet weak var subjectColor: UILabel!
    @IBOutlet weak var clockIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
