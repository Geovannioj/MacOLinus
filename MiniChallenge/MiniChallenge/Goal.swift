//
//  Goal.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Goal {
    
    var title: String = ""
    var description: String = ""
    var finishDate: Date
    var reminder: Reminder
    var frequency: Int = 0
    
    init(description:String, finishDate: Date, reminder: Reminder, frequency: Int) {
        self.description = description
        self.finishDate = finishDate
        self.reminder = reminder
        self.frequency = frequency
    }
    
}
