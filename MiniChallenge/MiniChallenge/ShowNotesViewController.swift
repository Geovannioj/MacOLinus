//
//  showNotesViewController.swift
//  Note
//
//  Created by Miguel Pimentel on 29/05/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import UIKit

class showNotesViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotes()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NoteService.sharedInstance.notes.count
    }
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "CreateNote", sender: Any?.self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowNotesTableViewCell

        cell.noteTitleLabe.text = NoteService.sharedInstance.notes[indexPath.row].title
        cell.noteText.text = NoteService.sharedInstance.notes[indexPath.row].noteDescription
        
        cell.noteTitleLabe.layer.cornerRadius = 3
        
        return cell
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


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
