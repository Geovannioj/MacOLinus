//
//  Teacher.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Teacher: NSObject {
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
    
    
}
