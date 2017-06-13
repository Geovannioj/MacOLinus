//
//  PresentNotesViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class PresentNotesViewController: UIViewController {
    
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContent()
        
        for aux in SingletonSubject.sharedInstance.subjects[SingletonSubject.sharedInstance.index].notes {
            
            print(aux.noteDescription)
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
        let subjectIndex = SingletonSubject.sharedInstance.index
        let noteIndex = NoteService.sharedInstance.index

        SingletonSubject.sharedInstance.subjects[subjectIndex].notes[noteIndex].noteDescription = noteContent.text!

        saveSubjects()


        performSegue(withIdentifier: "HomeNotes", sender: Any?.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    func setContent() {
        
        let subjectIndex = SingletonSubject.sharedInstance.index
        let noteIndex = NoteService.sharedInstance.index
        
        
        let noteName = SingletonSubject.sharedInstance.subjects[subjectIndex].notes[noteIndex].title
        let noteText = SingletonSubject.sharedInstance.subjects[subjectIndex].notes[noteIndex].noteDescription
        
        noteTitle.text = noteName
        noteContent.text = noteText
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
