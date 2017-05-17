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
    
    @IBOutlet weak var nextScreen: UIButton!
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var emptyTitleLavel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var taskTitle: String = ""
    var activityToEdit: Reminder?
    var segueDestination: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
        
        if let reminder = activityToEdit{
            taskTitleTextField.text = reminder.title
        }
        emptyTitleLavel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTitleTextField.becomeFirstResponder()
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        
        taskTitle = taskTitleTextField.text!
        if taskTitle.isEmpty{
            emptyTitleLavel.isHidden = false
        }else{
            SingletonActivity.sharedInstance.task.title = taskTitle
            performSegue(withIdentifier: "SubjectChoiceScreen", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let goToChooseSubject = segue.destination as? ChooseSubjectController{
            goToChooseSubject.segueDestination = segueDestination
        }
    }
    
    @IBAction func backButton(_ sender: Any){
        if(segueDestination == "GoToRemindersByDaily"){
            performSegue(withIdentifier: "BackToDailyCalendar", sender: Any?.self)
        }else if(segueDestination == "GoToRemindersByDone"){
            performSegue(withIdentifier: "BackToDoneAndPostponed", sender: Any?.self)
        }else if(segueDestination == "GoToRemindersByCalendar"){
            performSegue(withIdentifier: "BackToCalendar", sender: Any?.self)
        }
    }

}
