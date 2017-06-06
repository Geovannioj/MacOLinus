//
//  GoalCreated.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class GoalCreated: UIViewController {
    
    
    @IBAction func newUserGoalRequested(_ sender: Any) {
        
        let newUserGoal = GoalService.sharedInstance.user_goal
        GoalService.sharedInstance.user_goals.append(newUserGoal)
        
        saveUserGoals()
        
        CalendarViewController.pushedFromHomeGoal = true
        
//        performSegue(withIdentifier: "goalCreated", sender: Any?.self)
      
    }
    
    
    @IBOutlet weak var goalCreated: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfig()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        
        goalCreated.text = GoalService.sharedInstance.user_goal.title
        
    }
    
    
    // MARK: - Persist Data
    
    func saveUserGoals() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(GoalService.sharedInstance.user_goals, forKey: "UserGoals")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadUserGoals() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            GoalService.sharedInstance.user_goals = unarchiver.decodeObject(forKey: "UserGoals") as! [Goal]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
    }

    
    
    
    
    
}
