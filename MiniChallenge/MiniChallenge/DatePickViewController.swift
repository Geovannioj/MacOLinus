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
    @IBOutlet weak var labelValidate: UILabel!
    
    var taskTitle: String? = ""
    var taskDescription: String? = nil
    var isGrantedNotificationAccess:Bool = false
    var activityToEdit: Reminder?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            self.isGrantedNotificationAccess = granted
        })
        
        labelValidate.isHidden = true
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        
        if datePicker.date > Date(){
        
            let controlerPList = ControllerPList()
            
            //get date
            SingletonActivity.sharedInstance.task.time = datePicker.date
            
            let task:Reminder = SingletonActivity.sharedInstance.task
            
            task.scheduleNotification()
            
            SingletonActivity.sharedInstance.tasks.append(task)
            
            print("Titulo:\(task.title), Matéria:\(task.subject.title), Estatus:\(task.status)")
            
            //save the task in the PList
            controlerPList.saveReminders()
            
            //back to the screen to list the tasks
            self.navigationController?.popToRootViewController(animated: true)
            
            //clean the task reference
            SingletonActivity.sharedInstance.task = Reminder()
        
        }else{
            //mensagem de erro avisnado que o horário deve ser maior que o atual
            labelValidate.isHidden =  false
            
        }
        
    }
}
