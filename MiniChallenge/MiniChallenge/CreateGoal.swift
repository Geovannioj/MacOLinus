//
//  CreateGoal.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateGoal: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfig()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        
    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    internal func assignBackground() {
        
        let background = UIImage(named: "PurplePatternWithBoy")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }

}
