//
//  CreateGoal.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit



class CreateGoal: UIViewController {
    
    
    var goalType: String  = ""

    @IBOutlet weak var createSpecficGoal: UILabel!
    @IBOutlet weak var UserGoalFIeld: UITextField!
    
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
        
        createSpecficGoal.text = goalType
        
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


    @IBAction func userGoalTitleCreated(_ sender: Any) {
        
        let newUserGoal = Goal()
        
        if !(UserGoalFIeld.text?.isEmpty)! {
            
            newUserGoal.title = goalType + " " + UserGoalFIeld.text!
            GoalService.sharedInstance.user_goal = newUserGoal
        }
        
        performSegue(withIdentifier: "goalSaved", sender: Any?.self)
    
    }

}
