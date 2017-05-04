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
    
    
    var taskTitle: String = ""
    var activityToEdit: Reminder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
        
        if let reminder = activityToEdit{
            taskTitleTextField.text = reminder.title
        }
        
        //nextScreen.isEnabled = false
        
        
//        let notificationName = Notification.Name("Notificationidentifier")
//        NotificationCenter.default.addObserver(self, selector: #selector (AddTitleController.textFieleed(_:shouldChangeCharactersIn:replacementString:)) , name:notificationName, object: nil)
//        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTitleTextField.becomeFirstResponder()
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        taskTitle = taskTitleTextField.text!
        
        SingletonActivity.sharedInstance.task.title = taskTitle
        
    }
    
//    @objc(textField:shouldChangeCharactersInRange:replacementString:) func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//            let oldText = taskTitleTextField.text! as NSString
//            let newText = oldText.replacingCharacters(in: range, with: string) as NSString
//        
//            if newText.length > 0 {
//                nextScreen.isEnabled = true
//            } else {
//                nextScreen.isEnabled = false
//            }
//            return true
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !(taskTitleTextField.text?.isEmpty)!{
            nextScreen.isEnabled = true
        }else{
            nextScreen.isEnabled = false
        }
    }
}
