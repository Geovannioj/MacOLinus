//
//  ReminderViewController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 22/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ReminderViewController: UITableViewController {
    
    var reminders: [Reminder]
    
    required init?(coder aDecoder: NSCoder) {
        reminders = [Reminder]()
        
        let reminder1 = Reminder(title: "Molhar plantas", description: "molhar plantas de manhã")
        let reminder2 = Reminder(title: "Estudar", description: "iOS develpment")
        
        reminders.append(reminder1)
        reminders.append(reminder2)
        
        super.init(coder: aDecoder)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder", for: indexPath)
        let reminder = reminders[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = reminder.title
    
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = reminders[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(){
        let newRowIndex = reminders.count
        
        let reminder = Reminder(title: "I'm new", description: "I'm the description")
        
        reminders.append(reminder)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}
