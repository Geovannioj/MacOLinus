//
//  User.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class User : NSObject {
    
    static var subjects: [Subject] = []
    static var activites: [Activity] = []
//    var reminders: Reminders[]
    
    
    static func getSubjects() -> [Subject]{
        return User.subjects
    }
    
    static func addSubject(subject: Subject){
        subjects.append(subject)
        //Write code to save on the PList here
    }
  
    static func addActivity(activity: Activity){
        activites.append(activity)
        //Write code to save on the PList here
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
}
