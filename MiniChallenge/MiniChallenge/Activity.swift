//
//  Activity.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Activity: NSObject {
    
    var title: String
    var activityDescription: String
    var deadline: Date
//    var subject: Subject
//    var notification: Date
//   var rememberInterval: Int

    init(title: String, description: String, deadline:Date) {
        self.activityDescription = description
        self.title = title
        self.deadline = deadline
    }

//    init(title: String, description: String, deadline:Date, subject: Subject, notification: Date, rememberInterval: Int) {
//        self.activityDescription = description
//        self.title = title
//        self.deadline = deadline
//        self.subject = subject
//        self.notification = notification
//        self.rememberInterval = rememberInterval
//    }
    
}

