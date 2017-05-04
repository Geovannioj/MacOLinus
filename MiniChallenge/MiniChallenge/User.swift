//File: User.swift
//Description: Model for user


import Foundation

class User {
    
    
    //MARK: - Atributtes

    static var subjects = [Subject]()
    static var activites = [Reminder]()
    static var goals = [Goal]()
    
    //MARK: - Getters
    
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


    //MARK: - Load attributes data from plist

    
    func returnSubjects() -> [Subject] {
        
        var subjects = [Subject]()
        
        let path = dataFilePathForSubjects()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
            
        }
        
        return subjects
    }
    
    func dataFilePathForSubjects() -> URL {
        return documentsDirectory().appendingPathComponent("Subjects.plist")
        
    }
    
    func returnUserGoals() -> [Goal] {
        
        var userGoals = [Goal]()
        
        let path = dataFilePathForSubjects()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            userGoals = unarchiver.decodeObject(forKey: "UserGoals") as! [Goal]
            unarchiver.finishDecoding()
            
        }
        
        return userGoals
    }
    
    func dataFilePathForUserGoals() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
        
    }
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
}


