//
//  DatePickViewController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 01/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class DatePickViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var taskTitle: String? = ""
    var taskDescription: String? = nil
    
    var isGrantedNotificationAccess:Bool = false
    weak var delegate: AddReminderViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            self.isGrantedNotificationAccess = granted
        })

        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let task = Reminder(title: taskTitle!, time: datePicker.date)
        
        delegate?.addReminderViewController(self, didFinishAdding: task)
        
        print("tarefa:\(task.title)" + "data:\(task.time)")

    }
    
}
