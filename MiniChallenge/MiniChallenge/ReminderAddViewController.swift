//
//  ReminderAddViewController.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import UserNotifications


protocol AddReminderViewControllerDelegate: class {
    func addReminderControllerDidCancel(_ controller: ReminderAddViewController)
    func addReminderViewController(_ controller: ReminderAddViewController, didFinishAdding reminder: Reminder)
    func addReminderViewController(_ controller: ReminderAddViewController, didFinishEditing reminder: Reminder)
}

class ReminderAddViewController: UIViewController {

    var isGrantedNotificationAccess:Bool = false
    weak var delegate: AddReminderViewControllerDelegate?
    var reminderToEdit: Reminder?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let reminder = reminderToEdit{
            title = "Edit Reminder"
            titleField.text = reminder.title
            descriptionField.text = reminder.reminderDescription
            timePicker.date = reminder.time
            
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            self.isGrantedNotificationAccess = granted
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelNavBar(){
        delegate?.addReminderControllerDidCancel(self)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneNavBar(){
        if let reminder = reminderToEdit{
            reminder.title = titleField.text!
            reminder.reminderDescription = descriptionField.text!
            reminder.time = timePicker.date
            
            delegate?.addReminderViewController(self, didFinishEditing: reminder)
        }else {
            let title = titleField.text
            let description = descriptionField.text
            let time = timePicker.date
            
            let reminder = Reminder(title: title!, reminderDescription: description!, time: time)
        
            delegate?.addReminderViewController(self, didFinishAdding: reminder)
        }
    }

}
