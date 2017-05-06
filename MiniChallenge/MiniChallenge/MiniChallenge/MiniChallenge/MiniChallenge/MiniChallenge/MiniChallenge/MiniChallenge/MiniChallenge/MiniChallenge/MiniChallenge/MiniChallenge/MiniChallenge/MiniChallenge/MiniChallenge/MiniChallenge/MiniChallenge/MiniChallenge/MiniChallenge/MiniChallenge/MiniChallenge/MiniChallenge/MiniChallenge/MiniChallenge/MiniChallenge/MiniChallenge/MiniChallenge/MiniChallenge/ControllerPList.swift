//
//  ControllerPList.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 03/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class ControllerPList {

    func saveReminders(){
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SingletonActivity.sharedInstance.tasks, forKey: "Reminders")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    
    func documentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Reminders.plist")
    }
    
    func loadReminders(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonActivity.sharedInstance.tasks = unarchiver.decodeObject(forKey: "Reminders") as! [Reminder]
            unarchiver.finishDecoding()
        }

    }
}
