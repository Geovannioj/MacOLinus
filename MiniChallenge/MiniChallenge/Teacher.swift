import Foundation

class Teacher: NSObject, NSCoding {
    
    // MARK: - Attributes
    
    var name: String = ""
    var email: String = ""
    
    
    //MARK: - Constructors
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        self.name = name
    }
    
    
    init(name:String, email:String){
        self.name = name
        self.email = email
    }
    
    // MARK: - Helpers
    
    func updateName(newName:String){
        self.name = newName
    }
    
    func updateEmail(newEmail:String){
        self.email = newEmail
    }
    
    // MARK: - Code/Encode
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
//        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
//    }
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
//        coder.encode(email, forKey: "email")
    }
    
    
}
