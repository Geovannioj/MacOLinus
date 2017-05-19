//
//  SingletonActivity.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 02/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class SingletonActivity {
    
    var tasks: [Reminder] = [Reminder(title: "Teste", time: Date())]
    var task = Reminder()
    
    static let sharedInstance = SingletonActivity()
    
    private init() {
        
    }
    
    func createTask(title: String, time: Date) -> Reminder{
        let task = Reminder(title: title, time: time)
        
        return task
    }
    
    func addTaskToArry(task:Reminder){
        self.tasks.append(task)
    }
    
}
