//
//  DatePickViewController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 01/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class DatePickViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var taskTitle: String? = ""
    var taskDescription: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let task = Reminder(title: taskTitle!, time: datePicker.date)
        print("tarefa:\(task.title)" + "data:\(task.time)")
    }
    
}
