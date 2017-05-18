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
    @IBOutlet weak var backButton: UIButton!
    
    var taskTitle: String? = ""
    var taskDescription: String? = nil
    var isGrantedNotificationAccess:Bool = false
    var activityToEdit: Reminder?
    var segueRecived: String = ""
    var indexActivityToEdit: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        if indexActivityToEdit >= 0 {
            activityToEdit = SingletonActivity.sharedInstance.tasks[indexActivityToEdit]
        }
        
        if let activity = activityToEdit{
            datePicker.date = (activityToEdit?.time)!
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            self.isGrantedNotificationAccess = granted
        })
        
        labelValidate.isHidden = true
        
    }
    @IBAction func backBtn(_ sender: Any){
        if segueRecived == "DatePickViewController"{
            
            performSegue(withIdentifier: "GoBackToEditScreen3", sender: Any?.self)
        
        }else{
        
            performSegue(withIdentifier: "backToSubjectScreen", sender: Any?.self)
        }
        
    
    }
    @IBAction func saveBtn(_ sender: Any) {
        if datePicker.date > Date(){
            if segueRecived == "DatePickViewController" {
                
                EditActivityController.activityPassed.time = datePicker.date
                performSegue(withIdentifier: "GoBackToEditScreen3", sender: Any?.self)
                
            }else if (self.segueRecived == "GoToPostpone" || self.segueRecived == "GoToPostponeByDaily"){
                let controlerPList = ControllerPList()
                SingletonActivity.sharedInstance.tasks[self.indexActivityToEdit].time = datePicker.date
                
                SingletonActivity.sharedInstance.tasks[self.indexActivityToEdit].scheduleNotification()
                
                controlerPList.saveReminders()
                
                if segueRecived == "GoToPostpone"{
                    performSegue(withIdentifier: "GoToCalendar", sender: Any.self)
                }else{
                    performSegue(withIdentifier: "GoToDailyCalendar", sender: Any.self)
                }
            }
            
            let controlerPList = ControllerPList()
            //get date
            SingletonActivity.sharedInstance.task.time = datePicker.date
            let task:Reminder = SingletonActivity.sharedInstance.task
            task.scheduleNotification()
            SingletonActivity.sharedInstance.tasks.append(task)
            //save the task in the PList
            controlerPList.saveReminders()
            //clean the task reference
            SingletonActivity.sharedInstance.task = Reminder()
            performSegue(withIdentifier: "GoToCalendar", sender: Any?.self)
            
            
            if segueRecived == "AddActivity"{
                performSegue(withIdentifier: "GoToCalendar", sender: Any.self)
            }else if segueRecived == "AddActivityByDaily"{
                print("Segueeeee aqui47: \(segueRecived)")
                performSegue(withIdentifier: "GoToDailyCalendar", sender: Any.self)
            }else if segueRecived == "AddActivityByDone"{
                performSegue(withIdentifier: "GoToDoneAndPostponed", sender: Any.self)
            }
        }else{
            //mensagem de erro avisnado que o horário deve ser maior que o atual
            labelValidate.isHidden =  false
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoBackToEditScreen3"{
            
            if let goBackToEditScreen = segue.destination as? EditActivityController{
            
                goBackToEditScreen.indexActivityToEdit = indexActivityToEdit
            
            }
        }else if segue.identifier == "backToSubjectScreen"{
            if let backToChooseSubject = segue.destination as? ChooseSubjectController{
                backToChooseSubject.segueRecived = self.segueRecived
            }
        }
    }
}
