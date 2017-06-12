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
    @IBOutlet weak var createSubject: UIButton!
    
    var segueDestination: String = ""
    var subjects = [Subject]()
    var subject: Subject?
    var activityToEdit: Reminder?
    var auxSegue:String = ""
    var segueRecived: String = ""
    var indexActivity: Int = 0//-1
    var homeSubject = HomeSubject()
    var indexSubject : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        
        homeSubject.loadSubjects()
        
        //subjects = SingletonSubject.sharedInstance.subjects
        
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
        
        nextScreenBtn.isEnabled = false

    }
    
    @IBAction func backButon(_ sender: Any){
        if segueRecived == "ChooseSubjectController"{
            
            performSegue(withIdentifier: "GoToEditScreen2", sender: Any?.self)
        
        }else if segueRecived == "AddActivity"{
        
            performSegue(withIdentifier: "BackToAddTitle", sender: Any.self)
        
        }else if segueRecived == "AddActivityByDaily"{
        
            performSegue(withIdentifier: "BackToAddTitle", sender: Any.self)
        
        }else if segueRecived == "AddActivityByDone"{
        
            performSegue(withIdentifier: "BackToAddTitle", sender: Any.self)
        
        }
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        
        if segueRecived == "ChooseSubjectController"{
            
            EditActivityController.activityPassed.subject = SingletonSubject.sharedInstance.subjects[indexSubject!]
            performSegue(withIdentifier: "GoToEditScreen2", sender: Any?.self)
            
        }else{
            
            if(indexSubject != nil){
                SingletonActivity.sharedInstance.task.subject = SingletonSubject.sharedInstance.subjects[indexSubject!]
            }else{
                //SingletonActivity.sharedInstance.task.subject = Subject()
            }
            performSegue(withIdentifier: "GoToDateScreenWithSubject", sender: Any?.self)
        }
        
    }
    
    @IBAction func nextScreenWithOutSubjectAction(_ sender: Any) {
        if segueRecived == "ChooseSubjectController"{
            
            EditActivityController.activityPassed.subject = Subject()
            performSegue(withIdentifier: "GoToEditScreen2", sender: Any?.self)
            
        }else{
            SingletonActivity.sharedInstance.task.subject = Subject()
            performSegue(withIdentifier: "GoToDateScreenWithOutSubject", sender: Any?.self)
        }
        
    }
    
    @IBAction func createSubjectAction(_ sender: Any){
        performSegue(withIdentifier: "GoToAddSubject", sender: Any?.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonSubject.sharedInstance.subjects.count//subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subjects", for: indexPath)
        let subject = SingletonSubject.sharedInstance.subjects[indexPath.row]
        let label = cell.viewWithTag(10) as! UILabel
        let imageLabel = cell.viewWithTag(3) as! UILabel
        
        imageLabel.backgroundColor = SingletonSubject.sharedInstance.subjects[indexPath.row].color
        label.text = subject.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.indexSubject = indexPath.row
        //SingletonActivity.sharedInstance.task.subject = subjects[indexPath.row]
        nextScreenBtn.isEnabled = true
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToAddSubject" {
            
            if let toAddSubject = segue.destination as? CreateSubject{
                toAddSubject.segueData = self.segueRecived
            
            }

        }else if segue.identifier == "GoToEditScreen2"{
            if let backToEditScreen = segue.destination as? EditActivityController{
                backToEditScreen.indexActivityToEdit = indexActivity
                backToEditScreen.segueReceived = auxSegue
            }
        }else if segue.identifier == "BackToAddTitle"{
            if let goBackToAddTitle = segue.destination as? AddTitleController{
                goBackToAddTitle.segueRecived = self.segueRecived
            }
        }else if segue.identifier == "GoToDateScreenWithSubject"{
            if let goToDatePick = segue.destination as? DatePickViewController{
                goToDatePick.segueRecived = self.segueRecived
            }
        }else if segue.identifier == "GoToDateScreenWithOutSubject"{
            if let goToDatePick = segue.destination as? DatePickViewController{
                goToDatePick.segueRecived = self.segueRecived
            }
        }
    }
    
    // MARK: - Persist subject
    
    
    func saveSubjects() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(subjects, forKey: "Subjects")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
        
    }
    
    internal func loadSubjects() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Subjects.plist")
        
    }
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }

    

}
