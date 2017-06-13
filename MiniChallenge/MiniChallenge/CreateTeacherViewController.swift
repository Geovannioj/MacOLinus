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

    var segueData:String?
    var auxSegue:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validation.isHidden = true
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Config
    
    @IBAction func backToCreateSubject(_ sender: Any) {
        
        
        performSegue(withIdentifier: "CreateSubject", sender: Any?.self)
    }
    
    // MARK: - Config
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        hideKeyboardWhenTappedAround()
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
        
         if teacherNameField.text != ""{
            setTeacherName()
            performSegue(withIdentifier: "SelectSubjectColor", sender: Any?.self)
         }else{
            validation.isHidden = false
        }
//         performSegue(withIdentifier: "BackEditSubject", sender: Any?.self)
//        
    }
    
    @IBOutlet weak var validation: UILabel!
    func setTeacherName() {
        
        let newTeacher = Teacher()
        
        if !(teacherNameField.text?.isEmpty)! {
            
            newTeacher.name = teacherNameField.text!
        }
        
        SingletonSubject.sharedInstance.subject.teacher = newTeacher
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SelectSubjectColor" {
            if let nextScreen = segue.destination as? SelectSubjectColorViewController {
                nextScreen.segueData = segueData
            }
        } else if segue.identifier == "CreateSubject" {
            if let backScreen = segue.destination as? CreateSubject {
                backScreen.segueData = self.segueData
            }
        }
    }

    
}
