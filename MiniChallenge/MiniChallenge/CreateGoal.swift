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
    var segueReceived = ""
    var passedTitle = ""
    @IBOutlet weak var createSpecficGoal: UILabel!
    @IBOutlet weak var UserGoalFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: HomeGoal.pengoWhiteImage)
        self.validation.isHidden = true
        setConfig()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        if segueReceived == "EditGoalTitle"{
            let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = backButton
            UserGoalFIeld.text = passedTitle
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        hideKeyboardWhenTappedAround()
        
        
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
        self.view.backgroundColor = UIColor(patternImage: background!)
    }


    @IBAction func userGoalTitleCreated(_ sender: Any) {
        
        if segueReceived == "EditGoalTitle"{
            if UserGoalFIeld.text != ""{
                GoalService.sharedInstance.user_goal.title = UserGoalFIeld.text!
                _ = navigationController?.popViewController(animated: true)
            }else{
                validation.isHidden = false
            }
        }else{
            let newUserGoal = Goal()
            
            if UserGoalFIeld.text != "" {
                
                newUserGoal.title = goalType + " " + UserGoalFIeld.text!
                GoalService.sharedInstance.user_goal = newUserGoal
                
                saveUserGoals()
                
                performSegue(withIdentifier: "SelectDate", sender: Any?.self)
            }else{
                validation.isHidden = false
            }
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
