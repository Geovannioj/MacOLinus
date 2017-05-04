import Foundation

class Activity: NSObject {
    
    var title: String
    var deadline: Date
    var subject : Subject?
    var notification: Date?
    var rememberInterval: Int?
    
    init(title: String, deadline:Date) {
        self.title = title
        self.deadline = deadline
    }
    
    
    init(title: String, deadline:Date, subject: Subject, notification: Date, rememberInterval: Int) {
        self.title = title
        self.deadline = deadline
        self.subject = subject
        self.notification = notification
        self.rememberInterval = rememberInterval
        
    }
    
}
