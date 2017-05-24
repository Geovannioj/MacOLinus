//
//  CreateTeacherViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 23/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateTeacherViewController: UIViewController {
    
    @IBOutlet weak var teacherNameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Config
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
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
   
    // MARK: - Navigation
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
         setTeacherName()
        
         performSegue(withIdentifier: "SelectSubjectColor", sender: Any?.self)
//         performSegue(withIdentifier: "BackEditSubject", sender: Any?.self)
//        
    }
    
    func setTeacherName() {
        
        let newTeacher = Teacher()
        
        if !(teacherNameField.text?.isEmpty)! {
            
            newTeacher.name = teacherNameField.text!
        }
        
        SingletonSubject.sharedInstance.subject.teacher = newTeacher
    }

    
}
