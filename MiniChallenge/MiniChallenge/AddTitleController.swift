//
//  addTitleController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 29/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class AddTitleController: UIViewController {
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    var taskTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTitleTextField.becomeFirstResponder()
    }
    @IBAction func nextScreen(_ sender: Any) {
        taskTitle = taskTitleTextField.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseSubjectScreen" {
            if let chooseSubjectController = segue.destination as? ChooseSubjectController{
                chooseSubjectController.taskTitle = taskTitle
            }
        }
    }
        
}
