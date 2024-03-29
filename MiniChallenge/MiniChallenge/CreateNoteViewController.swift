//
//  CreateNoteViewController.swift
//  Note
//
//  Created by Miguel Pimentel on 29/05/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setContent() {
        
        NoteService.sharedInstance.note.title = noteTitleTextField.text!
        NoteService.sharedInstance.note.noteDescription = noteText.text!
    
        let newNote = NoteService.sharedInstance.note
        
        NoteService.sharedInstance.notes.append(newNote)
        
        saveNotes()
    
    }
    
    
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        setContent()
        
        performSegue(withIdentifier: "showNotes", sender: Any?.self)
        
    }
    
    func saveNotes() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(NoteService.sharedInstance.notes, forKey: "Notes")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadNotes() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            NoteService.sharedInstance.notes = unarchiver.decodeObject(forKey: "Notes") as! [Note]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Notes.plist")
    }
}
