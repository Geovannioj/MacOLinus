//
//  User.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class User {
    
    static var subjects: [Subject] = []
    static var activites: [Reminder] = []
    static var goals: [Goal] = []
    
    
    static func getSubjects() -> [Subject]{
        return subjects
    }
  
    
    func getSubjectsByName(name: String) -> [Subject] {
        
        var findedSubjects = [Subject]()
        
        for subject in User.subjects {
            
            if(subject.title.contains(name)) {
                findedSubjects.append(subject)
            }
        }
        
        return findedSubjects;
    }
    
   static func getActivities() -> [Reminder] {
        return activites
    }
    
    static func getGoals() -> [Goal] {
        return goals
    }
}
