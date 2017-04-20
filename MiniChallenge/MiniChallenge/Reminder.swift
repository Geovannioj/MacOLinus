//
//  Reminder.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class Reminder {
    
    var title: String = ""
    var reminderDescription: String = ""
    var date: Date
    var time: Date
    
    init(title: String, reminderDescription: String, date: Date,time: Date) {
        self.title = title
        self.reminderDescription = reminderDescription
        self.date = date
        self.time = time
    }
    
    
    
}
