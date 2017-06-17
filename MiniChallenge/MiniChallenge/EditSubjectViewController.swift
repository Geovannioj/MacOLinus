//
//  EditSubjectViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 24/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditSubjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editTableView: UITableView!
    let formFields = ["Matéria", "Professor","Cor"]
    var fields = ["", "", ""]
    var currentSubject : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: HomeSubject.pengoBlackImage)
        self.editTableView.tableFooterView = UIView()
        let saveButton = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(EditSubjectViewController.saveChanges))
        self.navigationItem.rightBarButtonItem = saveButton
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack(){
        performSegue(withIdentifier: "BackToHome", sender: Any?.self)
    }
    
    // MARK: - TableView Protocol
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditSubjectTableViewCell
        cell.formFieldLabel?.text = formFields[indexPath.row]
        cell.fieldLabel?.text = fields[indexPath.row]
        
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let editSubject = 0
        let editTeacher = 1

        
        if editSubject == indexPath.row {
            performSegue(withIdentifier: "EditSubjectTitle", sender: Any?.self)
        } else if editTeacher == indexPath.row {
            performSegue(withIdentifier: "EditTeacher", sender: Any?.self)
        } else {
            performSegue(withIdentifier: "EditColor", sender: Any?.self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    // MARK: - Setup
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        loadContent()
        
    }
    
    func assignBackground() {
        
        let background = UIImage(named: "greenPatternWithBoy")
        self.view.backgroundColor = UIColor(patternImage: background!)
    }
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    func loadContent() {
    
        fields[0] = SingletonSubject.sharedInstance.subject.title
        fields[1] = SingletonSubject.sharedInstance.subject.teacher.name
        self.tableView.reloadData()
    }

    func saveChanges(){
        SingletonSubject.sharedInstance.subjects[SingletonSubject.sharedInstance.index] = SingletonSubject.sharedInstance.subject
        
        updateActivities(currentSubject: currentSubject!, newSubject: SingletonSubject.sharedInstance.subject)
        
        saveSubjects()
        
        performSegue(withIdentifier: "BackToHome", sender: Any?.self)
    }
    
    // MARK: - Navigation
    
    func updateActivities(currentSubject : String, newSubject : Subject) {
        
        let controllerPlist = ControllerPList()
        
        let arrayLength = SingletonActivity.sharedInstance.tasks.count
        let copySingleton = SingletonActivity.sharedInstance.tasks
        
        for i in (0..<(arrayLength)) {
            
            if copySingleton[i].subject?.title == currentSubject {
                
                SingletonActivity.sharedInstance.tasks[i].subject = newSubject
                
            }
        }
        
        controllerPlist.saveReminders()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToHome" || segue.identifier == "HomeSubject"{
            CalendarViewController.pushedFromHomeSubject = true
        }else if segue.identifier == "EditColor"{
            if let editColor = segue.destination as? SelectSubjectColorViewController{
                editColor.segueReceived = segue.identifier!
                editColor.currentSubject = self.currentSubject
            }
        }else if segue.identifier == "EditTeacher"{
            if let editTeacher = segue.destination as? CreateTeacherViewController{
                editTeacher.segueData = segue.identifier
                editTeacher.passedTeacherName = SingletonSubject.sharedInstance.subject.teacher.name
            }
        }else if segue.identifier == "EditSubjectTitle"{
            if let editSubjectTitle = segue.destination as? CreateSubject{
                editSubjectTitle.segueData = segue.identifier
                editSubjectTitle.passedTitle = SingletonSubject.sharedInstance.subject.title
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
