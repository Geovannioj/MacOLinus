//
//  NoteViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 20/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Refers to AppDelegate
        let appDelagate = UIApplication.shared.delegate as! AppDelegate

        // Manager memory
        let context = appDelagate.persistentContainer.viewContext
        
        // Instanciating a new note
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context)
        
        newNote.setValue("Note 1", forKey: "title");
        newNote.setValue("This is just a note", forKey: "noteDescription");
        
        do {
            
            try context.save()
            
            print("Saved")
        
        } catch {
          
            print("An error has been found")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
           
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let noteTitle = result.value(forKey: ("title" as? String)!) {
                        
                        print(noteTitle)
                    }
                }
        
            } else {
                
                print("No results")
            }
            
        } catch {
            
            print("Could'not fetch results")
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
