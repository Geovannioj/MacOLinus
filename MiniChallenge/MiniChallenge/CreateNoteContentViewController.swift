//
//  CreateNoteContentViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateNoteContentViewController: UIViewController {

    @IBOutlet weak var noteContentText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addContentToNote() {

        let index = SingletonSubject.sharedInstance.index
        
        NoteService.sharedInstance.notes = SingletonSubject.sharedInstance.subjects[index].notes
        NoteService.sharedInstance.note.noteDescription = noteContentText.text!
        
        let newNote = NoteService.sharedInstance.note
        
        var notes = NoteService.sharedInstance.notes
        notes.append(newNote)
           
        // Set in Subject
        
        SingletonSubject.sharedInstance.subjects[index].notes = notes
  
        saveSubjects()

    }
 
    @IBAction func backButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "CreateNoteTitle", sender: Any?.self)
    }
    
    @IBAction func newNoteRequested(_ sender: Any) {
        
        addContentToNote()
        performSegue(withIdentifier: "NoteCreated", sender: Any?.self)
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
