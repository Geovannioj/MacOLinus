//
//  DoneAndPostponedActivitiesViewController.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 06/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import Dispatch

class DoneAndPostponedActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var doneActivities = [Reminder]()
    var postponedActivities = [Reminder]()
    let controllerPlsit = ControllerPList()
    
    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
   
    @IBOutlet weak var activitiesSegment: UISegmentedControl!
    @IBOutlet weak var activitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set done and postponed activitiesarrays
        checkDoneActivities(activities: SingletonActivity.sharedInstance.tasks)
        checkPostponedActivities(activities: SingletonActivity.sharedInstance.tasks)
        
        let nib = UINib(nibName: "DoneAndPostponedActivities", bundle: nil)
        activitiesTableView.register(nib, forCellReuseIdentifier: "DoneAndPostponedActivities")
        
        self.activitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier:"DoneAndPostponedActivities")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activitiesTableView.reloadData()
    }
    
    func checkDoneActivities(activities: [Reminder]){
        
        var count = 0
        for activity in activities{
            print(activity.status)
            if activity.status == 1 {
                if(activities[count] == activity){
                    doneActivities.append(activity)
                }
            }
            count = count + 1
        }
    }
    
    func checkPostponedActivities(activities: [Reminder]){
        
        for activity in activities{
            print(activity.status)
            if activity.status == 2 {
                postponedActivities.append(activity)
            }
        }
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        self.activitiesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        switch activitiesSegment.selectedSegmentIndex {
        //done activities
        case 0:
            returnValue = doneActivities.count
            break
        //postponed activities
        default:
            returnValue = postponedActivities.count
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func postponeAcitivity(activities:[Reminder], index:Int){
        print("data antiga:" + "\(activities[index].time)")
        activities[index].time = NSCalendar.current.date(byAdding: .day, value: 1, to: activities[index].time)!
        print("data depois:" + "\(activities[index].time)")
    }
    
    func maskTime(hour: Int, minutes: Int) -> String{
        
        var resultString = ""
        
        if hour <= 9  {
            resultString.append("0" + "\(hour):")
        } else {
            resultString.append("\(hour):")
        }
        
        if minutes <= 9 {
            resultString.append("0" + "\(minutes)")
        } else {
            resultString.append("\(minutes)")
        }
        
        return resultString
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DoneAndPostponedActivitiesTableViewCell", owner: self, options: nil)?.first as! DoneAndPostponedActivitiesTableViewCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        //edit button
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Cliquei em Edit")
            return true
        }
        
        //done button
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "done.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            //set status to done(=1)
            self.postponedActivities[indexPath.row].status = 1
            
            self.doneActivities.append(self.postponedActivities[indexPath.row])
            self.postponedActivities.remove(at: indexPath.row)
            self.controllerPlsit.saveReminders()
            self.activitiesTableView.reloadData()
            return true
        }
        
        //undo button
        let undoButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "undo.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            //set status to toDo(=0)
            self.doneActivities[indexPath.row].status = 0
            
            self.doneActivities.remove(at: indexPath.row)
            self.controllerPlsit.saveReminders()
            self.activitiesTableView.reloadData()
            return true
        }

        let calendar = Calendar.current
        
        switch activitiesSegment.selectedSegmentIndex {
        
        //done activities
        case 0:
            let activity = doneActivities[indexPath.row]
            cell.activityLabel.text = activity.title
            cell.colorLabel.backgroundColor? = UIColor.blue//activity.subject.color
            cell.iconImage.image = UIImage(named: "check.png")
            
            let day = calendar.component(.day, from: activity.time)
            let month = calendar.component(.month, from: activity.time)
            let year = calendar.component(.year, from: activity.time)
            let hour = calendar.component(.hour, from: activity.time)
            let minutes = calendar.component(.minute, from: activity.time)
            
            cell.timeLabel.text = "\(day)/\(month)/\(year) -" + maskTime(hour:hour, minutes:minutes)
            cell.subjectLabel.text = activity.subject.title
            
            cell.rightButtons = [undoButton]
            cell.rightSwipeSettings.transition = .border
            
            break
        default:
            let activity = postponedActivities[indexPath.row]
            cell.activityLabel.text = activity.title
            cell.colorLabel.backgroundColor = UIColor.blue//activity.subject.color
            cell.iconImage.image = UIImage(named: "clock.png")
            
            let day = calendar.component(.day, from: activity.time)
            let month = calendar.component(.month, from: activity.time)
            let year = calendar.component(.year, from: activity.time)
            let hour = calendar.component(.hour, from: activity.time)
            let minutes = calendar.component(.minute, from: activity.time)
            
            cell.timeLabel.text = "\(day)/\(month)/\(year) -" + maskTime(hour:hour, minutes:minutes)
            cell.subjectLabel.text = activity.subject.title
            
            cell.rightButtons = [doneButton]
            cell.rightSwipeSettings.transition = .border
            cell.leftButtons = [editButton]
            cell.leftSwipeSettings.transition = .border
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
