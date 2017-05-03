//
//  ShowActivities.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 01/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ShowActivities: UITableViewController, DatePickViewCovarollerDelegate{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        loadReminders()
        print("documentPath: \(documentsDirectory())")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonActivity.sharedInstance.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder", for: indexPath)
        let reminder = SingletonActivity.sharedInstance.tasks[indexPath.row]
        let label = cell.viewWithTag(100) as! UILabel
        label.text = reminder.title
        
        configureText(for: cell, with: reminder)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = SingletonActivity.sharedInstance.tasks[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func configureText(for cell: UITableViewCell, with reminder: Reminder){
        let label = cell.viewWithTag(100) as! UILabel
        label.text = reminder.title
    }
    
    func addReminderControllerDidCancel(_ controller: DatePickViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addReminderViewController(_ controller: DatePickViewController, didFinishEditing reminder: Reminder){
        
        reminder.scheduleNotification()
        
        if let index = SingletonActivity.sharedInstance.tasks.index(of: reminder){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: reminder)
            }
        }
        dismiss(animated: true, completion: nil)
        
    }

    func addReminderViewController(_ controller: DatePickViewController, didFinishAdding reminder: Reminder) {
        
        reminder.scheduleNotification()
        saveReminders()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        SingletonActivity.sharedInstance.tasks.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveReminders()
    }
    
    func saveReminders(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SingletonActivity.sharedInstance.tasks, forKey: "Reminders")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadReminders(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonActivity.sharedInstance.tasks = unarchiver.decodeObject(forKey: "Reminders") as! [Reminder]
            unarchiver.finishDecoding()
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
