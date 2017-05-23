//
//  HomeGoal.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class HomeGoal: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserGoals()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.goalTitleLabel.text = GoalService.sharedInstance.user_goals[indexPath.row].title
        
        let deleteButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "10")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            
            GoalService.sharedInstance.user_goals.remove(at: indexPath.row)
            
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.reloadData()
            
            self.saveUserGoals()
            
            
            return true
        }
        
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Done")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            return true
        }
        
        
        
        cell.rightButtons = [doneButton, deleteButton]
        cell.rightSwipeSettings.transition = .border
        
        let doneLaterButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Adiar")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            return true
        }
        
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "11")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            return true
        }
        
        cell.leftButtons = [editButton, doneLaterButton]
        cell.leftSwipeSettings.transition = .border
        
     
        return cell;
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
}
