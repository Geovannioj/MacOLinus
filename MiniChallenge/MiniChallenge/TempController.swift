//
//  TempController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 09/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class TempController: UIViewController {

    var data: String = "Nada"
    
    @IBOutlet weak var subjectCreatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setConfig()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Config
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        
        subjectCreatedLabel.text = data
        
    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    internal func assignBackground() {
        
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


}
