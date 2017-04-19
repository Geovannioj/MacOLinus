//
//  ActivityController.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class ActivityController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var activityDescription: UITextView!
    @IBOutlet weak var activityDate: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createActivity(){
        let activity = Activity(title: titleTextField.text!,
                                description: activityDescription.text,
                                deadline: activityDate.date)
        User.addActivity(activity: activity)
    }

}
