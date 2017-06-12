//
//  HomeSubject.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 08/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class HomeSubject: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var filteredActivityArray = [Reminder]()
    var subjectReceived =  Subject()
    
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var addButton: UIButton!
    let greenColor = UIColor(red: 0.2824, green: 0.9098, blue: 0.7765, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.addButton.clipsToBounds = true
        self.addButton.layer.cornerRadius = 20
        
        loadSubjects()
        
        self.tabBarItem.selectedImage = UIImage(named: "Subjects Fill")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = UIImage(named: "subject line")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: greenColor], for: .selected)
        
        for aux in SingletonSubject.sharedInstance.subjects {
            print(aux.title)
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CalendarViewController.pushedFromHomeGoal = false
        CalendarViewController.pushedFromHomeSubject = false
    }
    
    
    //MARK: - TableView Protocol
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let customRowHeight: CGFloat = 78.0
        
        return customRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SingletonSubject.sharedInstance.subjects.count
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
        
        cell.subjectTitleLabel.text = SingletonSubject.sharedInstance.subjects[indexPath.row].title
        cell.teacherNameLabel.text = SingletonSubject.sharedInstance.subjects[indexPath.row].teacher.name
    
        cell.subjectColorLabel.backgroundColor = SingletonSubject.sharedInstance.subjects[indexPath.row].color
        cell.subjectColorLabel.layer.cornerRadius = 20
        
        
        let deleteButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "delete")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            let deletingAlert = UIAlertController(title: "Excluindo disciplina", message: "Você deseja excluir a disciplina: \(SingletonSubject.sharedInstance.subjects[indexPath.row].title) ?", preferredStyle: .alert)
            
            let deleteButton = UIAlertAction(title: "Deletar", style: UIAlertActionStyle.cancel, handler: { action in
                
                let subject = SingletonSubject.sharedInstance.subjects[indexPath.row].title
                SingletonSubject.sharedInstance.subjects.remove(at: indexPath.row)
                let indexPaths = [indexPath]
                tableView.deleteRows(at: indexPaths, with: .automatic)
                tableView.reloadData()
                self.deleteSubjectsActivity(subject: subject)
                self.saveSubjects()
                
                
                
            })
            
            let cancelButton = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                //Do nothing
            })
            
            deletingAlert.addAction(deleteButton)
            deletingAlert.addAction(cancelButton)
            
            self.present(deletingAlert, animated: true, completion: nil)
            return true
        }
        
        cell.rightButtons = [deleteButton]
        cell.rightSwipeSettings.transition = .border
        
        
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            SingletonSubject.sharedInstance.subject = SingletonSubject.sharedInstance.subjects[indexPath.row]
            SingletonSubject.sharedInstance.index  = indexPath.row
            self.subjectReceived = SingletonSubject.sharedInstance.subjects[indexPath.row]
            
            self.performSegue(withIdentifier: "EditSubject", sender: Any?.self)

            return true
        }
      
        cell.leftButtons = [editButton]
        cell.leftSwipeSettings.transition = .border
        
        cell.subjectColorLabel.clipsToBounds = true
        cell.subjectColorLabel.layer.cornerRadius = 4
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        return UIView()
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let subjectSelected = SingletonSubject.sharedInstance.subjects[indexPath.row]
        
        SingletonSubject.sharedInstance.subject = subjectSelected
        SingletonSubject.sharedInstance.index  = indexPath.row
        
        filterSubjectsActivity(subjectName: subjectSelected.title)
        self.subjectReceived = subjectSelected
        
        performSegue(withIdentifier: "HomeNotes", sender: Any?.self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func filterSubjectsActivity(subjectName: String){
            
        for activity in SingletonActivity.sharedInstance.tasks{
            
            if activity.subject?.title == subjectName{
                
                filteredActivityArray.append(activity)
                
            }
            
        }
    }
    
    func deleteSubjectsActivity(subject : String) {
        
        let controllerPlist = ControllerPList()
        
        let arrayLength = SingletonActivity.sharedInstance.tasks.count
        let copySingleton = SingletonActivity.sharedInstance.tasks
        
        for i in (0..<(arrayLength)) {
            print(i)
            
            if copySingleton[i].subject?.title == subject {
                let id = copySingleton[i].reminderID
                self.deleteActivityByID(id: id)
                
            }
        }
        
        controllerPlist.saveReminders()
        
    }
    
    func deleteActivityByID(id:Int) {
        
        let controllerPlist = ControllerPList()
        var counter = 0
        
        for activity in SingletonActivity.sharedInstance.tasks {
            
            if activity.reminderID == id {
                SingletonActivity.sharedInstance.tasks.remove(at: counter)
            }
            
            counter += 1
        }
        
        controllerPlist.saveReminders()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HomeNotes"{
            if let nextScreen = segue.destination as? HomeNotesViewController {
                
                nextScreen.filteredActivities = self.filteredActivityArray
                nextScreen.subjectReceived = self.subjectReceived
            }
        }else if segue.identifier == "EditSubject" {
            if let nextScreen = segue.destination as? EditSubjectViewController {
                nextScreen.currentSubject = self.subjectReceived.title
            }
        }
    }

    
    // MARK: - Persist Data
    
    func saveSubjects() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(SingletonSubject.sharedInstance.subjects, forKey: "Subjects")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
        
    }
    
    func loadSubjects() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonSubject.sharedInstance.subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Subjects.plist")
        
    }
}
