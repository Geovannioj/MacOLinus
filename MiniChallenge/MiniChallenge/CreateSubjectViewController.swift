//
//  CreateSubjectViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateSubjectViewController: UIViewController {
    
    var subjects: [Subject] = []
    
    
    @IBOutlet weak var subjectTitleField: UITextField!
    @IBOutlet weak var subjectTeacherField: UITextField!
    @IBOutlet weak var placeSubjectField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSubjects() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    
    func saveSubjects() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(subjects, forKey: "Subjects")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Subjects.plist")
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        let title = subjectTitleField.text
        let teacher = subjectTeacherField.text
        let place = placeSubjectField.text
        
        
        let newSubject = Subject(title: title!, place: place!, teacher: teacher!)
        
        subjects.append(newSubject)
        
        saveSubjects()
        
    }
    
    
}
