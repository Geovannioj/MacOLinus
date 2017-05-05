//
//  ShowSubjectViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class ShowSubjectViewController: UITableViewController {
    
    var subjects: [Subject] = [Subject(title: "snsdjs", place: "äsuhaus", teacher: "sdhsud")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Return the number of subjects
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfSubjects = loadSubjects().count
        
        return numberOfSubjects
    }
    
    
    // change cell to subject values
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subject", for: indexPath)
        let subject = subjects[indexPath.row]
        let label = cell.viewWithTag(1) as! UILabel
        
        label.text = subject.title
        
        
        return cell
    }
    
    
    func loadSubjects() -> [Subject] {
        
        let path = dataFilePath()
        
        
        
        if let data = try?  Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
            
        }
        
        return subjects
        
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Subjects.plist")
    }
    
    
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
