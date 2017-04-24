//
//  ReminderViewController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 22/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ReminderViewController: UITableViewController, AddReminderViewControllerDelegate {
    
    var reminders: [Reminder]
    
    required init?(coder aDecoder: NSCoder) {
        reminders = [Reminder]()
        super.init(coder:aDecoder)
        loadReminders()
        
    }
    func loadReminders(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            reminders = unarchiver.decodeObject(forKey: "Reminders") as! [Reminder]
            unarchiver.finishDecoding()
        }
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
    
    func addReminderControllerDidCancel(_ controller: ReminderAddViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addReminderViewController(_ controller: ReminderAddViewController, didFinishAdding reminder: Reminder) {
        
        let newRowIndex = reminders.count
        reminders.append(reminder)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
        saveReminders()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        reminders.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveReminders()
    }
    func saveReminders(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(reminders, forKey: "Reminders")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "AddReminder" {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ReminderAddViewController
            controller.delegate = self
        }else if segue.identifier == "EditReminder"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ReminderAddViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.reminderToEdit = reminders[indexPath.row]
            }
        }
    }
    func documentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Reminders.plist")
    }
    
    
}
