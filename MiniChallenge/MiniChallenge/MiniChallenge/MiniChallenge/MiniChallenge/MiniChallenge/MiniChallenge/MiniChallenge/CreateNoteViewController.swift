//
//  CreateNoteViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let note = Note(title: "T1", noteDescription: "Study to first test at january 1st")
        
        var notes = [Note]()
        
        notes.append(note)
        
        saveNote(notes: notes)
        
        let notesList = loadNotes()
        
        print(notesList[0].noteDescription)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    internal func saveNote(notes: [Note]) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: notes)
        UserDefaults.standard.set(encodedData, forKey: "notes")
        
    }
    
    internal func loadNotes() -> [Note] {
        
        if let data = UserDefaults.standard.data(forKey: "notes"),
            let notesList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Note] {
            
            return notesList
            
        } else {
            print("An error has been ocurred")
        }
        
        return [Note]()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
