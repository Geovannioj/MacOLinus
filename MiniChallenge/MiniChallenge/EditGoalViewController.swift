//
//  EditGoalViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditGoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let formFields = ["Meta"]
    var fields = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: HomeGoal.pengoWhiteImage)
        let saveButton = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(EditGoalViewController.saveChanges))
        self.navigationItem.rightBarButtonItem = saveButton
        configLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContent()
    }
    
    func goBack(){
        performSegue(withIdentifier: "backToHomeGoal", sender: Any?.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
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
        print("Aquiiiiii")
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        
        saveContent()
        
        performSegue(withIdentifier: "backToHomeGoal", sender: Any?.self)
    }
    
    func saveChanges(){
        saveContent()
        performSegue(withIdentifier: "backToHomeGoal", sender: Any?.self)
    }
    // MARK: - Setup
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditGoalTitle"{
            if let nextScreen = segue.destination as? CreateGoal{
                nextScreen.segueReceived = segue.identifier!
                nextScreen.passedTitle = GoalService.sharedInstance.user_goal.title
            }
        }
        else if segue.identifier == "backToHomeGoal" || segue.identifier == "HomeGoal"{
            CalendarViewController.pushedFromHomeGoal = true
        }
    }
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
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
        self.tableView.reloadData()
    }
    
    func saveContent() {
    
        GoalService.sharedInstance.user_goals[GoalService.sharedInstance.user_goal.index] = GoalService.sharedInstance.user_goal
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
