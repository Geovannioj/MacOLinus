//
//  HomeNotesViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class HomeNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var subjectTitleLabel: UILabel!
    @IBOutlet weak var subjectColorLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfig()
        loadSubjects()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setConfig() {
        
        subjectColorLabel.backgroundColor = SingletonSubject.sharedInstance.subject.color
        subjectTitleLabel.text = SingletonSubject.sharedInstance.subject.title
    }
  
    @IBAction func createNotePressed(_ sender: Any) {
        
        performSegue(withIdentifier: "CreateNoteTitle", sender: Any?.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SingletonSubject.sharedInstance.subject.notes.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeNotesTableViewCell
        cell.noteTitle.text = SingletonSubject.sharedInstance.subject.notes[indexPath.row].title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
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
