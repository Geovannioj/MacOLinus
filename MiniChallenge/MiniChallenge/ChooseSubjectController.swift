//
//  ChooseSubjectController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 30/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ChooseSubjectController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var subjectsTableView: UITableView!
    
    var subjects = [Subject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        let subject1 = Subject(title: "ICC")
        let subject2 = Subject(title: "Cálculo1")
        let subject3 = Subject(title: "IAL")
        
        subjects.append(subject1)
        subjects.append(subject2)
        subjects.append(subject3)
        
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
    }
    
    @IBAction func nextScreen(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subjects", for: indexPath)
        let subject = subjects[indexPath.row]
        let label = cell.viewWithTag(10) as! UILabel
        label.text = subject.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

