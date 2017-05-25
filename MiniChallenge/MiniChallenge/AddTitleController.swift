//
//  addTitleController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 29/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//
import Foundation
import UIKit

class AddTitleController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextScreen: UIButton!
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var emptyTitleLavel: UILabel!
    
    var taskTitle: String = ""
    var activityToEdit: Reminder?
    var activityToBeSaved: Reminder?
    var segueRecived: String = ""
    var auxSeuge: String = ""
    var indexActivityArray: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
        
        if indexActivityArray >= 0{
            activityToEdit = SingletonActivity.sharedInstance.tasks[indexActivityArray]
        }
        
        
        if activityToEdit != nil{
            taskTitleTextField.text = activityToEdit?.title
        }
        
        print(segueRecived)
        emptyTitleLavel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTitleTextField.becomeFirstResponder()
    }
    @IBAction func backButton(_ sender: Any){
        
        if segueRecived == "Reminders"{
            performSegue(withIdentifier: "GoToEditScreen", sender: Any?.self)
        }else if segueRecived == "AddActivity"{
            performSegue(withIdentifier: "GoToCalendar", sender: Any?.self)
        }else if segueRecived == "AddActivityByDaily"{
            performSegue(withIdentifier: "GoToDailyCalendar", sender: Any.self)
        }else if segueRecived == "AddActivityByDone"{
            performSegue(withIdentifier: "GoToDoneAndPostponed", sender: Any.self)
        }
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        
        self.taskTitle = self.taskTitleTextField.text!
        
        if taskTitle.isEmpty{
        
            emptyTitleLavel.isHidden = false
        
        }else if !(taskTitle.isEmpty){
            
            if activityToEdit != nil{
                
                activityToEdit?.title = self.taskTitle
                EditActivityController.activityPassed.title = self.taskTitle
                print("Aquiiiiiiiiiiii")
                print(SingletonActivity.sharedInstance.tasks[indexActivityArray].title)
                performSegue(withIdentifier: "GoBackToEditScreen", sender: Any?.self)
            }else{
                
                SingletonActivity.sharedInstance.task.title = taskTitle
                performSegue(withIdentifier: "SubjectChoiceScreen", sender: Any?.self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToEditScreen" {
           
            if let data = segue.destination as? EditActivityController{

                data.indexActivityToEdit = indexActivityArray
                data.segueReceived = auxSeuge
                
            }
        }else if segue.identifier == "GoBackToEditScreen"{
            if let goToEditScreen = segue.destination as? EditActivityController{
                goToEditScreen.indexActivityToEdit = indexActivityArray
                goToEditScreen.segueReceived = auxSeuge
                
            }
        }
        else if segue.identifier == "SubjectChoiceScreen"{
            if let dataToSubject = segue.destination as? ChooseSubjectController{
                dataToSubject.activityToEdit?.title = self.taskTitleTextField.text!
                dataToSubject.segueRecived = self.segueRecived
            }
        }
    }
    
}
