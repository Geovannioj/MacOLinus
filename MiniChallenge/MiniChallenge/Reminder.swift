//
//  Reminder.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class Reminder: NSObject, NSCoding {
    var title: String = ""
    var reminderDescription: String = ""
    var time: Date = Date()
    var notification: [UNUserNotificationCenter] = []
    
    // Path to save the reminders
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL1 = DocumentsDirectory.appendingPathComponent("reminders")
    
    // enum for property types
    struct PropertyKey {
        static let titleKey = "title"
        static let dateKey = "date"
        static let timeKey = "time"
        static let reminderDescriptionKey = "reminderDescription"
        static let notificationKey = "notification"
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(reminderDescription, forKey: "description")
        aCoder.encode(time, forKey: "time")
        
    }
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "Title") as! String
        reminderDescription = aDecoder.decodeObject(forKey: "description") as! String
        time = aDecoder.decodeObject(forKey: "time") as! Date
        
        super.init()
    }
    
    override init(){
        super.init()
    }
    
    init(title: String, reminderDescription: String, time: Date) {
        self.title = title
        self.reminderDescription = reminderDescription
        self.time = time
    }
    
    init(title: String, reminderDescription: String, time: Date, notification:UNUserNotificationCenter) {
        self.title = title
        self.reminderDescription = reminderDescription
        self.time = time
        self.notification.append(notification)
    }
    
    init(title:String, description:String) {
        self.title = title
        self.reminderDescription = description
    }
}
