//
//  ShowNotesTableViewCell.swift
//  Note
//
//  Created by Miguel Pimentel on 29/05/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit

class ShowNotesTableViewCell: UITableViewCell {

    @IBOutlet weak var noteColorLabel: UILabel!
    
    @IBOutlet weak var noteTitleLabe: UILabel!
    @IBOutlet weak var noteText: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
