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
    var indexActivityArray: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
        
        activityToEdit = SingletonActivity.sharedInstance.tasks[indexActivityArray]
        
        if let reminder = activityToEdit{
            taskTitleTextField.text = reminder.title
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
        }
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        
        taskTitle = taskTitleTextField.text!
        
        if let reminder = activityToEdit{
            //salvar o texto do textField
            activityToBeSaved?.title = taskTitle
            //activityToEdit?.title = taskTitleTextField.text!
            performSegue(withIdentifier: "GoToEditScreen", sender: Any?.self)
        
        }else if taskTitle.isEmpty{
        
            emptyTitleLavel.isHidden = false
        
        }else if !(taskTitle.isEmpty){
        
            SingletonActivity.sharedInstance.task.title = taskTitle
            performSegue(withIdentifier: "SubjectChoiceScreen", sender: Any?.self)
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToEditScreen" {
           
            if let data = segue.destination as? EditActivityController{
                data.activityPassed.title = self.taskTitleTextField.text!
                data.indexActivityToEdit = indexActivityArray
                data.activityToBeSaved.title = (self.activityToBeSaved?.title)!
            }
        }else {
            if let dataToSubject = segue.destination as? ChooseSubjectController{
                dataToSubject.activityToEdit?.title = self.taskTitleTextField.text!
            }
        }
    }
    
}
