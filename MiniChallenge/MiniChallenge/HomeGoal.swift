//
//  HomeGoal.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import UserNotifications


class HomeGoal: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let purpleColor = UIColor(colorLiteralRed: 0.4078, green: 0.4314, blue: 0.8784, alpha: 1)
    var doneGoals = [Goal]()
    var goals = [Goal]()
    static let pengoWhiteImage = UIImage(named: "pengoWhite")
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myPurple = UIColor(red: 104.0/255, green: 110.0/255, blue: 224.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = myPurple
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        //the line below removes the black line above the navigation item (Probably will be useful at some point, do not delete it)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.titleView = UIImageView(image: HomeGoal.pengoWhiteImage)
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.addButton.clipsToBounds = true
        self.addButton.layer.cornerRadius = 20
        loadUserGoals()
        loadContent()

        self.navigationController?.tabBarItem.image = UIImage(named: "Goal Line")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "goals fill")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: purpleColor], for: .selected)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CalendarViewController.pushedFromHomeGoal = false
        CalendarViewController.pushedFromHomeSubject = false
    }
    
    // TableView Protocol
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let customRowHeight: CGFloat = 78.0
    
        return customRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GoalService.sharedInstance.user_goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGoals", for: indexPath) as! GoalCellsTableViewCell
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor =  UIColor(red: 0.4078, green:0.4314, blue:0.8784, alpha: 1.0).cgColor

        
        cell.goalTitleLabel.text = GoalService.sharedInstance.user_goals[indexPath.row].title
        
        let deleteButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "delete")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            
            let deletingAlert = UIAlertController(title: "Excluindo meta", message: "Você deseja excluir a meta: \(GoalService.sharedInstance.user_goals[indexPath.row].title) ?", preferredStyle: .alert)
            
            let deleteButton = UIAlertAction(title: "Deletar", style: UIAlertActionStyle.cancel, handler: { action in
                
                let notificationID = GoalService.sharedInstance.user_goals[indexPath.row].title
                print(notificationID)
                
                let center = UNUserNotificationCenter.current()
                center.removePendingNotificationRequests(withIdentifiers: ["\(notificationID)"])
                
                GoalService.sharedInstance.user_goals.remove(at: indexPath.row)
                self.saveUserGoals()
                let indexPaths = [indexPath]
                tableView.deleteRows(at: indexPaths, with: .fade)
                tableView.reloadData()
            })
            
            let cancelButton = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                //Do nothing
            })
            
            deletingAlert.addAction(deleteButton)
            deletingAlert.addAction(cancelButton)
            
            self.present(deletingAlert, animated: true, completion: nil)
            
            return true
        }
        
        cell.rightButtons = [deleteButton]
        cell.rightSwipeSettings.transition = .border
        
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            GoalService.sharedInstance.user_goal = GoalService.sharedInstance.user_goals[indexPath.row]
            GoalService.sharedInstance.user_goal.index = indexPath.row
            
            self.performSegue(withIdentifier: "EditGoal", sender: Any?.self)
            
            return true
        }
        
        cell.leftButtons = [editButton]
        cell.leftSwipeSettings.transition = .border
    
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditGoal"{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: nil, action: #selector(EditGoalViewController.goBack))
        } else{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: nil, action: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
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
    
    func loadContent() {
        
        goals = GoalService.sharedInstance.user_goals
    
    }

}
