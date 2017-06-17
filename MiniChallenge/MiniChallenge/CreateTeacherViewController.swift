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
    var passedTeacherName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: HomeSubject.pengoBlackImage)
        validation.isHidden = true
        configLayout()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        if segueData == "EditTeacher"{
            let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = backButton
            teacherNameField.text = passedTeacherName
        }
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
        hideKeyboardWhenTappedAround()
    }
    
    func assignBackground() {
        
        let background = UIImage(named: "greenPatternWithBoy")
        self.view.backgroundColor = UIColor(patternImage: background!)
    }
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
   
    // MARK: - Navigation
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
         if teacherNameField.text != ""{
            if segueData == "EditTeacher"{
                SingletonSubject.sharedInstance.subject.teacher.name = teacherNameField.text!
                _ = navigationController?.popViewController(animated: true)
            }
            else{
                setTeacherName()
                performSegue(withIdentifier: "SelectSubjectColor", sender: Any?.self)
            }
         }else{
            validation.isHidden = false
        }
        
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
