//
//  SubjectTableViewCell.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 05/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class SubjectTableViewCell: MGSwipeTableCell {


    @IBOutlet weak var subjectTitleLabel: UILabel!
    @IBOutlet weak var subjectColorLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
