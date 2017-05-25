import Foundation

class Goal: NSObject, NSCoding {
    
    // MARK: - Attributes
    
    var title: String = ""
    var goalDescription: String = ""
    var time: Date = Date()
    var index: Int = -1
    var done: Bool = false
    
    // MARK: - Path to user goals
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("userGoals")
    
    // MARK: - Constructors
    
    override init() {
        
    }
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, time: Date) {
        self.title = title
        self.time = time
    }
    
    
    // MARK: - Persist subject
    
   
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
    }
}
