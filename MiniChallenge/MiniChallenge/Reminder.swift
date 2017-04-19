//
//  Reminder.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Reminder {
    
    var title: String = ""
    var description: String = ""
    var date: Date
    var time: Date
    
    init(title: String, description: String, date: Date,time: Date) {
        self.title = title
        self.description = description
        self.date = date
        self.time = time
    }
    
    
    
}
