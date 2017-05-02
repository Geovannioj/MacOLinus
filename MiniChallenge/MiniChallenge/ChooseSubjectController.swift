//
//  ChooseSubjectController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 30/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit
//UITableViewDataSource, UITableViewDelegate
class ChooseSubjectController: UIViewController{
    
    @IBOutlet weak var subjectsTableView: UITableView!
    
    var subjects = [Subject]()
    
    var taskTitle: String = ""
    var subject: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.png")!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickTimeScreen" {
            if let datePickViewController = segue.destination as? DatePickViewController{
                datePickViewController.taskTitle = taskTitle
                
            }
        }
    }
    
    
    
    @IBAction func nextScreen(_ sender: Any) {
    }

}

extension ChooseSubjectController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = subjectsTableView.dequeueReusableCell(withIdentifier: "Subjects", for: indexPath) 
        
        cell.textLabel?.text = "uheuehuehuehueheuh"
        
        return cell
    }
}
