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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        subjectCreatedLabel.text = SingletonSubject.subjectSharedInstance.subject.title
        
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

    
}
