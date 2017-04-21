//
//  Subject.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class Subject: NSObject, NSCoding{
    
    var title: String = ""
    var place: String = ""
    var icon: UIImage = UIImage()
    var schedule: [Date] = []
    var color: UIColor = UIColor()
    var teacher: Teacher = Teacher()
    var note: Note = Note()
    
    
    init(title: String, place: String, icon: UIImage, schedule: Date, color: UIColor, teacher: Teacher, note: Note){
        self.title = title
        self.place = place
        self.icon = icon
        self.schedule.append(schedule)
        self.color = color
        self.teacher = teacher
        self.note = note
    }
    
    
    init(title: String) {
        self.title = title
        self.place = String()
        self.icon = UIImage()
        self.color = UIColor()
        self.teacher = Teacher()
        self.note = Note()
    }
    
    init(title: String, address: String) {
        self.title = title
        self.place = address
    }
    
    //update methods
    func updateTitle(newTitle: String){
        self.title = newTitle
    }
    
    func updatePlace(newPlace: String){
        self.place = newPlace
    }
    
    func updateIcon(newIcon: UIImage){
        self.icon = newIcon
    }
    
    func updateSchedule(oldShedule: Date, newSchedule: Date){
        let indexOfOldSchedule = self.schedule.index(of: oldShedule)
        self.schedule[indexOfOldSchedule!] = newSchedule
    }
    
    func updateColor(newColor: UIColor){
        self.color = newColor
    }
    
    func updateTeacher(newTecher: Teacher){
        self.teacher = newTecher
    }
    
    func updateNote(newNote: Note){
        self.note = newNote
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.place = decoder.decodeObject(forKey: "place") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(place, forKey: "place")
    }
}
