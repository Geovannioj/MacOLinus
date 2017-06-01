import Foundation
import UIKit

class Subject: NSObject, NSCoding {
    
    // MARK: - Attributes
    
    var title: String = ""
    var place: String = ""
    var icon: UIImage = UIImage()
    var schedule: [Date] = []
    var color: UIColor = UIColor()
    var teacher: Teacher = Teacher()
    var missedClasses = [NSDate]()
    var notes = [Note]()
    var faults: Int64 = 0
    
    // MARK: - Path to persist data
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("subjects")
    
    // MARK: - Constructors
    
    override init() {
        super.init()
        self.title = String()
        self.place = String()
        self.color = UIColor.white
    }
    
    init(teacher: Teacher) {
        self.teacher = teacher
    }
    
    init(title: String, place: String, icon: UIImage, schedule: Date, color: UIColor, teacher: Teacher, note: Note){
        self.title = title
        self.place = place
        self.icon = icon
        self.schedule.append(schedule)
        self.color = color
        self.teacher = teacher
    }
    
    init(title: String, teacher: Teacher, color: UIColor) {
        self.title = title
        self.teacher = teacher
        self.color = color
    }
    
    
    init(title: String) {
        self.title = title
        self.place = String()
        self.icon = UIImage()
        self.color = UIColor()
        self.teacher = Teacher()
    }
    
    init(title: String, address: String) {
        self.title = title
        self.place = address
    }
    
    init(title: String, place: String, teacher: String) {
        
        self.title = title
        self.place = place
        self.teacher =  Teacher(name: teacher)
        
    }
    
    // MARK: - Persist subject
    
    required init(coder decoder: NSCoder) {
        
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.place = decoder.decodeObject(forKey: "place") as? String ?? ""
        self.color = decoder.decodeObject(forKey: "color") as? UIColor ?? UIColor.black
        self.teacher.name =  decoder.decodeObject(forKey: "teacherName") as? String ?? ""
        self.notes = decoder.decodeObject(forKey: "notes") as? [Note] ?? [Note]()
        self.faults = decoder.decodeInt64(forKey: "faults")
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(place, forKey: "place")
        coder.encode(color, forKey: "color")
        coder.encode(teacher.name, forKey: "teacherName")
        coder.encode(notes, forKey: "notes")
        coder.encode(faults, forKey: "faults")
    }
    
}
