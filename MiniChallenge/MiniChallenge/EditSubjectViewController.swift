//
//  EditSubjectViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 24/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditSubjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let formFields = ["Matéria", "Professor","Cor"]
    var fields = ["", "", ""]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    func loadContent() {
    
        fields[0] = SingletonSubject.sharedInstance.subject.title
        fields[1] = SingletonSubject.sharedInstance.subject.teacher.name
    
        
        
    }

    
    // MARK: - Navigation
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        let index = SingletonSubject.sharedInstance.index
        let editedSubject = SingletonSubject.sharedInstance.subjects[index]
        
        editedSubject.title = SingletonSubject.sharedInstance.subject.title
        editedSubject.teacher.name = SingletonSubject.sharedInstance.subject.teacher.name
        
        saveSubjects()
        
        performSegue(withIdentifier: "BackToHome", sender: Any?.self)
        
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
