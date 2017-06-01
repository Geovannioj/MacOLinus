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

    @IBOutlet weak var segmentControl: UISegmentedControl!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubjects()
        
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    
    func setup() {
        
        subjectColor.backgroundColor = SingletonSubject.sharedInstance.subject.color
        subjectTitle.text = SingletonSubject.sharedInstance.subject.title
        numberOfFaults.text = String(SingletonSubject.sharedInstance.subject.faults)
    }
    
    // MARK: - Actions

    @IBAction func segmentControlChanged(_ sender: Any) {
        
       
        if segmentControl.selectedSegmentIndex == 1 {
            
            let subjectWithFault = SingletonSubject.sharedInstance.subject
            let index = SingletonSubject.sharedInstance.index
            
            if Int(numberOfFaults.text!) != nil {
                subjectWithFault.faults = Int(numberOfFaults.text!)!
            }
            
            SingletonSubject.sharedInstance.subjects[index] = subjectWithFault
            saveSubjects()
        }
    }
    
    @IBAction func faultAdded(_ sender: Any) {
        
        if var faults = Int(numberOfFaults.text!) {
            faults = faults + 1
            numberOfFaults.text = String(describing: faults)
        }
    }
    
    @IBAction func faultRemoved(_ sender: Any) {
        
        if var faults = Int(numberOfFaults.text!) {
            
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
            subjectWithFault.faults = Int(numberOfFaults.text!)!
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
