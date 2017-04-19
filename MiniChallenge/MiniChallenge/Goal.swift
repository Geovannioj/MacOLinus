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
    var timeToBeReminded: Date
    var frequency: Int = 0
    
    init(description:String, finishDate: Date, timeToBeReminded: Date, frequency: Int) {
        self.description = description
        self.finishDate = finishDate
        self.timeToBeReminded = timeToBeReminded
        self.frequency = frequency
    }
    
}
