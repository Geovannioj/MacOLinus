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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Helpers
    
    internal func cleanBuffer () {
        
        SingletonSubject.sharedInstance.subject = Subject()
    }
    
    
    
    // MARK: - Config Layout
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
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
        
        setNewContent()
        performSegue(withIdentifier: "BackToEditSubject", sender: Any?.self)
    }
    
    
    func setNewContent() {
        
        SingletonSubject.sharedInstance.subject.title = newSubectTitleLabel.text!
    }
}
