//
//  CreateSubjectViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateSubjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let softwareDesign = Subject(title: "Desenho de Software", address: "MOCAP")
        let ux = Subject(title: "Interação Humano Computador", address: "MOCAP")
        
        var subjects = [Subject]()
        
        subjects.append(softwareDesign)
        subjects.append(ux)
        
        saveSubject(subjects: subjects)
        
        
        let subjectsList = loadSubjects()
        
        print(subjectsList[0].title)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    internal func saveSubject(subjects: [Subject]) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: subjects)
        UserDefaults.standard.set(encodedData, forKey: "subjects")
        
    }
    
    internal func loadSubjects() -> [Subject]{
        
        if let data = UserDefaults.standard.data(forKey: "subjects"),
            let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Subject] {
            
            return myPeopleList
            
        } else {
            print("An error has been ocurred")
        }
        
        return [Subject]()
    }


    
}
