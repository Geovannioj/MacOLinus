//
//  ChooseSubjectController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 30/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ChooseSubjectController: UITableViewController {
    
    
    var taskTitle: String = ""
    var subject: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickTimeScreen" {
            if let datePickViewController = segue.destination as? DatePickViewController{
                datePickViewController.taskTitle = taskTitle
            }
        }
    }

}
