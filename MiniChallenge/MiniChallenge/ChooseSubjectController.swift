//
//  ChooseSubjectController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 30/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ChooseSubjectController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var subjectsTableView: UITableView!
    @IBOutlet weak var nextScreenBtn: UIButton!
    @IBOutlet weak var nextScreenWithOutSubject: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var subjects = [Subject]()
    var subject: Subject?
    var activityToEdit: Reminder?
    var persistData = PersistSubjectData()
    var segueRecived: String = ""
    var indexActivity: Int = 0//-1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        
        subjects = persistData.returnSubjects()
    
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
        
        nextScreenBtn.isEnabled = false

    }
    @IBAction func backButon(_ sender: Any){
        if segueRecived == "ChooseSubjectController"{
            performSegue(withIdentifier: "GoToEditScreen2", sender: Any?.self)
        }else{
            
        }
    }
    @IBAction func nextScreen(_ sender: Any) {
        
        if segueRecived == "ChooseSubjectController"{
            
            EditActivityController.activityPassed.subject = subject
            performSegue(withIdentifier: "GoToEditScreen2", sender: Any?.self)
            
        }else{
            
            if(subject != nil){
                SingletonActivity.sharedInstance.task.subject = subject!
            }else{
                SingletonActivity.sharedInstance.task.subject = Subject()
            }
            performSegue(withIdentifier: "GoToDateScreenWithSubject", sender: Any?.self)
        }
        
    }
    
    @IBAction func nextScreenWithOutSubjectAction(_ sender: Any) {
        SingletonActivity.sharedInstance.task.subject = Subject()
        performSegue(withIdentifier: "GoToDateScreenWithOutSubject", sender: Any?.self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subjects", for: indexPath)
        let subject = subjects[indexPath.row]
        let label = cell.viewWithTag(10) as! UILabel
        let imageLabel = cell.viewWithTag(3) as! UILabel
        
        imageLabel.backgroundColor = subjects[indexPath.row].color
        label.text = subject.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        subject = subjects[indexPath.row]
        //SingletonActivity.sharedInstance.task.subject = subjects[indexPath.row]
        nextScreenBtn.isEnabled = true
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToAddSubject" {
            
            if let toAddSubject = segue.destination as? SubjectViewController{
            
                toAddSubject.segueData = segue.identifier
            
            }
        }else if segue.identifier == "GoToEditScreen2"{
            if let backToEditScreen = segue.destination as? EditActivityController{
                backToEditScreen.indexActivityToEdit = indexActivity
            }
        }
    }
}
