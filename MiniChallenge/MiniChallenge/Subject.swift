//
//  Subject.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class Subject{
    var title: String = ""
    var place: String = ""
    var icon: UIImage? = nil
    var schedule: [Date] = []
    var color: UIColor? = nil
    var teacher: Teacher? = nil
    var note: Note? = nil
    
    init(title:String) {
        self.title = title
    }
    
    init(title:String, place:String, icon:UIImage, schedule:Date, color:UIColor, teacher:Teacher, note:Note){
        self.title = title
        self.place = place
        self.icon = icon
        self.schedule.append(schedule)
        self.color = color
        self.teacher = teacher
        self.note = note
    }
}
