import Foundation

class Goal {
    
    
    // MARK: - Attributes
    
    var title: String = ""
    var goalDescription: String = ""
    var timeToBeReminded: Date
    
    
    // MARK: - Constructors
    
    init(title: String, goalDescription: String, timeToBeReminded: Date) {
        self.title = title
        self.goalDescription = goalDescription
        self.timeToBeReminded = timeToBeReminded
    }
    
    init(timeToBeReminded: Date) {
        self.timeToBeReminded = timeToBeReminded
    }
    
    // MARK: - Path to user goals
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("userGoals")
}
