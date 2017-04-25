import Foundation

class Teacher: NSObject, NSCoding {
    
    var name: String = ""
    var email: String = ""
    
    
    init(name:String, email:String){
        self.name = name
        self.email = email
    }
    
    
    override init() {
        self.name = String()
        self.email = String()
    }
    
    //update methods
    func updateName(newName:String){
        self.name = newName
    }
    
    func updateEmail(newEmail:String){
        self.email = newEmail
    }
    
    // Methods to persist data
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
    }
    
    
}
