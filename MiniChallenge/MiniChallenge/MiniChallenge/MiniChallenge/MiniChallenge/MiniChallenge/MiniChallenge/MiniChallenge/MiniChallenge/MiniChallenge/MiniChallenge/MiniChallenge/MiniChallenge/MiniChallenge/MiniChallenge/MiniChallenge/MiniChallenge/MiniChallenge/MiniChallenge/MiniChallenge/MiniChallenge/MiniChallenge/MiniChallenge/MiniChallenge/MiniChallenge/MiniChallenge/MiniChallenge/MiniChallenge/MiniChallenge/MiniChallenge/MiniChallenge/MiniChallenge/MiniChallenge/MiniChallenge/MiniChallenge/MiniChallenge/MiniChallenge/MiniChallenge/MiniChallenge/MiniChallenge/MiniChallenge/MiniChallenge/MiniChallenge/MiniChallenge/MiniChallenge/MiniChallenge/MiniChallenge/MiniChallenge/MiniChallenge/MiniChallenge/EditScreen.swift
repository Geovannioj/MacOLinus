//
//  EditScreen.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 04/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit
//, UITableViewDelegate, UITableViewDataSource
class EditScreen: UIViewController{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var dateTime: UIDatePicker!
    @IBOutlet weak var btnCreateSubject: UIButton!
    @IBOutlet weak var tableSubjects: UITableView!
    
    var subjects = [Subject]()
    var subject = Subject(title: "")
    var activityToEdit: Reminder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        let subject1 = Subject(title: "ICC")
        let subject2 = Subject(title: "Cálculo1")
        let subject3 = Subject(title: "IAL")
        
        subjects.append(subject1)
        subjects.append(subject2)
        subjects.append(subject3)
        
//        tableSubjects.delegate = self
//        tableSubjects.dataSource = self
        
        dateTime.date = (activityToEdit?.time)!
        titleTextField.text = (activityToEdit?.title)
        
        
        
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return subjects.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Subjects", for: indexPath)
//        let subject = subjects[indexPath.row]
//        let label = cell.viewWithTag(1) as! UILabel
//        label.text = subject.title
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//            subjects[indexPath.row] = (activityToEdit?.subject)!
//            SingletonActivity.sharedInstance.task.subject = subjects[indexPath.row]
//        
//        }
    
    @IBAction func save(_ sender: Any) {
//        let controlerPList = ControllerPList()
//        
//        SingletonActivity.sharedInstance.task.time = dateTime.date
//        SingletonActivity.sharedInstance.task.title = titleTextField.text!
//        
//        let task:Reminder = SingletonActivity.sharedInstance.task
//        
//        task.scheduleNotification()
//        
//        SingletonActivity.sharedInstance.tasks.append(task)
//        
//        
//        if let index = SingletonActivity.sharedInstance.tasks.index(of: task){
//                    //save the task in the PList
//        controlerPList.saveReminders()
//        
//        //back to the screen to list the tasks
//        self.navigationController?.popToRootViewController(animated: true)
//        
//        //clean the task reference
//        SingletonActivity.sharedInstance.task = Reminder()
        
        
//    }
        }


}



