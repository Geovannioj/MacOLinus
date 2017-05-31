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
        
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        
        setContent()
    }
    
    func setContent() {
        
        let subjectIndex = SingletonSubject.sharedInstance.index
        let noteIndex = NoteService.sharedInstance.index
        
        
        let noteName = SingletonSubject.sharedInstance.subjects[subjectIndex].notes[noteIndex].title
        let noteText = SingletonSubject.sharedInstance.subjects[subjectIndex].notes[noteIndex].noteDescription
        
        noteTitle.text = noteName
        noteContent.text = noteText
    }

}
