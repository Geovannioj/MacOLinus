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

protocol DatePickViewCovarollerDelegate: class {
    func addReminderControllerDidCancel(_ controller: DatePickViewController)
    func addReminderViewController(_ controller: DatePickViewController, didFinishAdding reminder: Reminder)
    func addReminderViewController(_ controller: DatePickViewController, didFinishEditing reminder: Reminder)
}

class DatePickViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var taskTitle: String? = ""
    var taskDescription: String? = nil
    
    var isGrantedNotificationAccess:Bool = false
    weak var delegate: DatePickViewCovarollerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            self.isGrantedNotificationAccess = granted
        })

        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        SingletonActivity.sharedInstance.task.time = datePicker.date
        
        let task:Reminder = SingletonActivity.sharedInstance.task
        
        task.scheduleNotification()
        SingletonActivity.sharedInstance.tasks.append(task)
        
        delegate?.addReminderViewController(self, didFinishAdding: task)
        self.navigationController?.popToRootViewController(animated: true)
        SingletonActivity.sharedInstance.task = Reminder()
    }
    
}
