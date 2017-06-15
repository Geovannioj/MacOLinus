//
//  SubjectFaultsViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class SubjectFaultsViewController: UIViewController {
    
    @IBOutlet weak var subjectColor: UILabel!
    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var numberOfFaults: UILabel!

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
 
    var filteredActivities = [Reminder]()
    var subjectReceived:Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plusButton.clipsToBounds = true
        self.minusButton.clipsToBounds = true
        self.plusButton.layer.cornerRadius = 20
        self.minusButton.layer.cornerRadius = 20
        
        loadSubjects()
        setup()

        self.subjectColor.clipsToBounds = true
        self.subjectColor.layer.cornerRadius = 8
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Setup
    
    func setup() {
        
        subjectColor.backgroundColor = SingletonSubject.sharedInstance.subject.color
        subjectTitle.text = SingletonSubject.sharedInstance.subject.title
        numberOfFaults.text = String(SingletonSubject.sharedInstance.subject.faults)
    }
    
    // MARK: - Actions

    @IBAction func subjectButtonPressed(_ sender: Any) {
        
      performSegue(withIdentifier: "HomeSubject", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSubject" {
            CalendarViewController.pushedFromHomeSubject = true
            let subjectWithFault = SingletonSubject.sharedInstance.subject
            let index = SingletonSubject.sharedInstance.index
            if Int64(numberOfFaults.text!) != nil {
                subjectWithFault.faults = Int64(numberOfFaults.text!)!
            }
            SingletonSubject.sharedInstance.subjects[index] = subjectWithFault
            saveSubjects()

        }else if segue.identifier == "HomeTasks" {
            
            if let nextScreen = segue.destination as? ShowSubjectsActivity {
                nextScreen.subjectReceived = self.subjectReceived
                nextScreen.receivedArray = self.filteredActivities
            }
        }else if segue.identifier == "HomeNotes" {
            
            if let nextScreen = segue.destination as? HomeNotesViewController {
                nextScreen.subjectReceived = self.subjectReceived
                nextScreen.filteredActivities = self.filteredActivities
            }
        }
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        
       
        if segmentControl.selectedSegmentIndex == 1 {
            performSegue(withIdentifier: "HomeNotes", sender: Any?.self)
        }else if segmentControl.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "HomeTasks", sender: Any?.self)
        }
    }
    
    @IBAction func faultAdded(_ sender: Any) {
        
        if var faults = Int64(numberOfFaults.text!) {
            faults = faults + 1
            numberOfFaults.text = String(describing: faults)
        }
    }
    
    @IBAction func faultRemoved(_ sender: Any) {
        
        if var faults = Int64(numberOfFaults.text!) {
            
            if faults > 0 {
                faults = faults - 1
                numberOfFaults.text = String(describing: faults)
        
            }
        }
    }
    
    
    
    // MARK: - Persist Data
    
    func setFaults() {
        
        let subjectWithFault = SingletonSubject.sharedInstance.subject
        let index = SingletonSubject.sharedInstance.index
        
        if Int(numberOfFaults.text!) != nil {
            subjectWithFault.faults = Int64(numberOfFaults.text!)!
        }
        
        SingletonSubject.sharedInstance.subjects[index] = subjectWithFault
        saveSubjects()
    }
    
    
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
