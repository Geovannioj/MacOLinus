//
//  EditSubjectTeacherViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 24/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditSubjectTeacherViewController: UIViewController {
    
    @IBOutlet weak var newTeacherName: UITextField!

    @IBOutlet weak var validationLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        validationLbl.isHidden = true
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "EditSubject", sender: Any?.self)
    }

    // MARK: - Config Layout
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
       newTeacherName.text = SingletonSubject.sharedInstance.subject.teacher.name
        
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

    @IBAction func nextScreenPressed(_ sender: Any) {
        
        if newTeacherName.text != ""{
            setNewContent()
            performSegue(withIdentifier: "BackToEditSubject", sender: Any?.self)
        }else{
            validationLbl.isHidden = false
        }
    
    }
    
    func setNewContent() {
        
        SingletonSubject.sharedInstance.subject.teacher.name = newTeacherName.text!
    }

}
