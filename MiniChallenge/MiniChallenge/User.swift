//
//  User.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class User {
    
    var subjects: [Subject] = []
//    var activites: Activity[]
//    var reminders: Reminders[]
    
    
    func getSubjects() -> [Subject]{
        return subjects
    }
  
    
    func getSubjectsByName(name: String) -> [Subject] {
        
        var findedSubjects = [Subject]()
        
        for subject in subjects {
            
            if(subject.title.contains(name)) {
                findedSubjects.append(subject)
            }
        }
        
        return findedSubjects;
    }
}
