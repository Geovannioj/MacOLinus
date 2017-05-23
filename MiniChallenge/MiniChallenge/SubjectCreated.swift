//
//  SubjectCreated.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 08/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class SubjectCreated: UIViewController {
    
    @IBOutlet weak var subjectCreatedLabel: UILabel!
    
    var subjectName: String = ""
    
    var subjects = [Subject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    // MARK: - Config Layout 

    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
        subjectCreatedLabel.text = SingletonSubject.sharedInstance.subject.title
    }
    
    func assignBackground() {
        
        let background = UIImage(named: "greenPatternWithBoy")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }

    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    //MARK: - Persist Data
    
    func loadSubjects()  {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    
//    func returnSubjects() -> [Subject] {
//        
//        let path = dataFilePath()
//        
//        if let data = try? Data(contentsOf: path) {
//            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
//            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
//            unarchiver.finishDecoding()
//            
//        }
//        
//        return subjects
//    }
    
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Subjects.plist")
    }
    


    
}
