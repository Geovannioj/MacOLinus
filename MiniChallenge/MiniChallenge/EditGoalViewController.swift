//
//  EditGoalViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditGoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let formFields = ["Meta"]
    var fields = [""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView Protocol
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditGoalTableViewCell
        
        cell.formFieldLabel?.text = formFields[indexPath.row]
        cell.fieldLabel?.text = fields[indexPath.row]
        
        return cell
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "HomeGoal", sender: Any?.self)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        performSegue(withIdentifier: "EditGoalTitle", sender: Any?.self)
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        saveContent()
        
        performSegue(withIdentifier: "backToHomeGoal", sender: Any?.self)
    }
    // MARK: - Setup
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHomeGoal" || segue.identifier == "HomeGoal"{
            CalendarViewController.pushedFromHomeGoal = true
        }
    }
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        loadContent()
        
        
    }
    
    func assignBackground() {
        
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
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    func loadContent() {
        
        fields[0] = GoalService.sharedInstance.user_goal.title
    
    }
    
    func saveContent() {
    
        GoalService.sharedInstance.user_goals[GoalService.sharedInstance.user_goal.index] =  GoalService.sharedInstance.user_goal
        
        
        saveUserGoals()
    }
    
    //MARK: - Persist Data
    
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

    
    
    // MARK: - Navigation

}
