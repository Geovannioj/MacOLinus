//
//  CreateGoal.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit



class CreateGoal: UIViewController {
    
    
    @IBOutlet weak var validation: UILabel!
    var goalType: String  = ""

    @IBOutlet weak var createSpecficGoal: UILabel!
    @IBOutlet weak var UserGoalFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.validation.isHidden = true
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
        
        
        if goalType != "" {
            createSpecficGoal.text = goalType
        } else {
            createSpecficGoal.text = "Qual a sua meta ?"
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "GoalOptions", sender: Any?.self)
    }

    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
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
            
            GoalService.sharedInstance.user_goals.append(newUserGoal)
            saveUserGoals()
            
            performSegue(withIdentifier: "SelectDate", sender: Any?.self)
        }else{
            validation.isHidden = false
        }
    
    }
    
    
    //MARK: - Persist Data
    
    func saveUserGoals() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(GoalService.sharedInstance.user_goals, forKey: "UserGoals")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
        
    }

}
