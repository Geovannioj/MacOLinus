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
    @IBOutlet weak var nextScreenBtn: UIButton!
    
    var subjects = [Subject]()
    var subject: Subject?
    var activityToEdit: Reminder?
    var persistData = PersistSubjectData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        
        subjects = persistData.returnSubjects()
    
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
        
        nextScreenBtn.isEnabled = false
        

    }
    
    
    @IBAction func nextScreen(_ sender: Any) {
        
     //   SingletonActivity.sharedInstance.task.subject = subject!
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subjects", for: indexPath)
        let subject = subjects[indexPath.row]
        let label = cell.viewWithTag(10) as! UILabel
        let imageLabel = cell.viewWithTag(3) as! UILabel
        
        imageLabel.backgroundColor = subjects[indexPath.row].color
        label.text = subject.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //subject = subjects[indexPath.row]
        SingletonActivity.sharedInstance.task.subject = subjects[indexPath.row]
        nextScreenBtn.isEnabled = true
    
    }
}
