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

    var reminderID: Int = 0
    var title: String = ""
    var reminderDescription: String = ""
    var time: Date = Date()
    var subject :Subject = Subject(title: "Sem matéria")
    var status: Int = 0
    var day: Int = 0
    var month: Int = 0
    var year: Int = 0
    var hour: Int = 0
    var minutes: Int = 0
    
    
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(reminderDescription, forKey: "description")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(subject, forKey: "Subject")
        aCoder.encode(status, forKey: "Status")
        aCoder.encode(reminderID, forKey:"ReminderID")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        reminderID = aDecoder.decodeInteger(forKey: "ReminderID")
        title = aDecoder.decodeObject(forKey: "Title") as! String
        reminderDescription = aDecoder.decodeObject(forKey: "description") as! String
        time = aDecoder.decodeObject(forKey: "time") as! Date
        subject = aDecoder.decodeObject(forKey: "Subject") as! Subject
        status = aDecoder.decodeInteger(forKey: "Status")
        
        super.init()
    }
    
    override init(){
        reminderID = Reminder.nextReminderID()
        super.init()
    }
    
    init(title: String, time: Date){
        self.title = title
        self.time = time
        
    }
    init(title: String, subject: Subject, time: Date){
        self.title = title
        self.subject = subject
        self.time = time
    }
   
    func scheduleNotification(){
        if time > Date(){
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = title
            content.sound = UNNotificationSound.default()
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest( identifier: "\(reminderID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled notification \(request) for reminderID \(reminderID)")
        }
    }
    class func nextReminderID() -> Int {
        let userDefaults = UserDefaults.standard
        let reminderID = userDefaults.integer(forKey: "ReminderID")
        userDefaults.set(reminderID + 1, forKey: "ReminderID")
        userDefaults.synchronize()
        return reminderID
    }
 
}


