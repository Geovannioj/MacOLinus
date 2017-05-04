//
//  ShowActivities.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 01/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ShowActivities: UITableViewController{
    
    let controlerPList = ControllerPList()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        loadReminders()
        print("documentPath: \(controlerPList.documentsDirectory())")
        
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
        _ = SingletonActivity.sharedInstance.tasks[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func configureText(for cell: UITableViewCell, with reminder: Reminder){
        let label = cell.viewWithTag(100) as! UILabel
        label.text = reminder.title
    }

    func addTask(_ controller: DatePickViewController, didFinishAdding reminder: Reminder) {
        reminder.scheduleNotification()
        controlerPList.saveReminders()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        SingletonActivity.sharedInstance.tasks.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        controlerPList.saveReminders()
    }
    
    func loadReminders(){
        let path = controlerPList.dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonActivity.sharedInstance.tasks = unarchiver.decodeObject(forKey: "Reminders") as! [Reminder]
            unarchiver.finishDecoding()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditActivity"{
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                let controller1 = segue.destination as! EditScreen
                
                controller1.activityToEdit = SingletonActivity.sharedInstance.tasks[indexPath.row]

            }
        }
    }


}
