//
//  EditSubjectTitleViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 24/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditSubjectTitleViewController: UIViewController {

    @IBOutlet weak var newSubectTitleLabel: UITextField!
    
    @IBOutlet weak var validationLbl: UILabel!
    
    var currentSubject : String?
    
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
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "EditSubject", sender: Any?.self)
    }
    
    
    // MARK: - Helpers
    
    internal func cleanBuffer () {
        
        SingletonSubject.sharedInstance.subject = Subject()
    }
    
    
    
    // MARK: - Config Layout
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        hideKeyboardWhenTappedAround()
        
        newSubectTitleLabel.text = SingletonSubject.sharedInstance.subject.title
        
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
        
        if newSubectTitleLabel.text != ""{
            setNewContent()
            performSegue(withIdentifier: "BackToEditSubject", sender: Any?.self)
        }else{
            validationLbl.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToEditSubject"{
            if let backScreen = segue.destination as? EditSubjectViewController {
                backScreen.currentSubject = self.currentSubject
            }
        }
    }
    
    func setNewContent() {
        
        SingletonSubject.sharedInstance.subject.title = newSubectTitleLabel.text!
    }

}
