//
//  Teacher.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Teacher: NSObject, NSCoding{
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
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(email, forKey: "Email")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
    }

}
