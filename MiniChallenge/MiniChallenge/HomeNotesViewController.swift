//
//  HomeNotesViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class HomeNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var subjectTitleLabel: UILabel!
    @IBOutlet weak var subjectColorLabel: UILabel!

    var filteredActivities = [Reminder]()
    var subjectReceived: Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        loadSubjects()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    // MARK: - Actions
    

    @IBAction func subjectButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "HomeSubject", sender: Any?.self)
    }
    
    @IBAction func createNotePressed(_ sender: Any) {
        
        performSegue(withIdentifier: "CreateNoteTitle", sender: Any?.self)
    }
    
    @IBAction func SegmentControlChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 2 {
            performSegue(withIdentifier: "SubjectFault", sender: Any?.self)
        } else if segmentControl.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "showActivities", sender: Any?.self)
        }
    }

    
    func setupLayout() {
        
        subjectColorLabel.backgroundColor = SingletonSubject.sharedInstance.subject.color
        subjectTitleLabel.text = SingletonSubject.sharedInstance.subject.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SingletonSubject.sharedInstance.subject.notes.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeNotesTableViewCell
        
        let index = SingletonSubject.sharedInstance.index
        cell.noteTitle.text = SingletonSubject.sharedInstance.subjects[index].notes[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 84.0
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        NoteService.sharedInstance.index = indexPath.row
        
        performSegue(withIdentifier: "PresentNotes", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivities" {
            if let nextScreen = segue.destination as? ShowSubjectsActivity {
                nextScreen.receivedArray = self.filteredActivities
                nextScreen.subjectReceived = self.subjectReceived
            }
        }else if segue.identifier == "SubjectFault"{
                if let nextScreen = segue.destination as? SubjectFaultsViewController {
                    nextScreen.subjectReceived = self.subjectReceived
                    nextScreen.filteredActivities = self.filteredActivities
                }
            
        }else if segue.identifier == "HomeSubject"{
            CalendarViewController.pushedFromHomeSubject = true
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
