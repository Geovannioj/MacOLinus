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

class Reminder {
    var title: String = ""
    var reminderDescription: String = ""
    var time: Date
    var notification: [UNUserNotificationCenter] = []
    
    // Path to save the reminders
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")
    
    // enum for property types
    struct PropertyKey {
        static let titleKey = "title"
        static let dateKey = "date"
        static let timeKey = "time"
        static let reminderDescriptionKey = "reminderDescription"
        static let notificationKey = "notification"
    }
    
    init(title: String, reminderDescription: String, time: Date, notification:UNUserNotificationCenter) {
        self.title = title
        self.reminderDescription = reminderDescription
        self.time = time
        self.notification.append(notification)
    }
    
    
}
