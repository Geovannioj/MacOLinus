//
//  HomeSubject.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 08/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class HomeSubject: UIViewController, UITableViewDelegate, UITableViewDataSource {

  
    let subjects = SingletonSubject.subjectSharedInstance.subjects
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        config()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Controller config 
    
    internal func config() {
        
//        let subjectsLoaded = PersistSubjectData()
//        subjectsLoaded.loadSubjects()
//        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let customRowSize: CGFloat = 78.0
        
        return customRowSize
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
        
        cell.subjectTitleLabel.text = subjects[indexPath.row].title
        cell.subjectColorLabel.backgroundColor = subjects[indexPath.row].color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        return UIView()
    }
    
    
}
