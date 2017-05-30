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

    var toDoActivities = [Reminder]()
    var doneActivities  = [Reminder]()
    var postponedActivities = [Reminder]()
    var indexActivity = 0
    let controllerPlist = ControllerPList()
    
    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
   
    @IBOutlet weak var activitiesSegment: UISegmentedControl!
    @IBOutlet weak var activitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set done and postponed activitiesarrays
        
        controllerPlist.loadReminders()
        
        print("Bem aquiiiiiiiiiiii")
        print(SingletonActivity.sharedInstance.tasks[indexActivity].title)
        checkActivities(activities: SingletonActivity.sharedInstance.tasks)
        
        let nib = UINib(nibName: "DoneAndPostponedActivities", bundle: nil)
        activitiesTableView.register(nib, forCellReuseIdentifier: "DoneAndPostponedActivities")
        
        self.activitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier:"DoneAndPostponedActivities")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activitiesTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        activitiesTableView.beginUpdates()
        activitiesTableView.endUpdates()

    }
    func checkActivities(activities:[Reminder]){
        for currentActivity in activities{
            if currentActivity.status == 0{
                toDoActivities.append(currentActivity)
            }else if currentActivity.status == 1{
                doneActivities.append(currentActivity)
            }else{
                postponedActivities.append(currentActivity)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddActivityByDone"{
            if let goToReminders = segue.destination as? AddTitleController{
                goToReminders.segueRecived = segue.identifier!
            }
        }else if segue.identifier == "EditActivity"{
            if let goToEdit = segue.destination as? EditActivityController{
                goToEdit.segueReceived = (segue.identifier)!
                goToEdit.indexActivityToEdit = self.indexActivity
            }
        }else if segue.identifier == "GoToPostponeByDone"{
            if let goToDatePick = segue.destination as? DatePickViewController{
                goToDatePick.indexActivityToEdit = self.indexActivity
                goToDatePick.segueRecived = segue.identifier!
            }
        }
    }
    
    @IBAction func AddActivity(_ sender: Any) {
        performSegue(withIdentifier: "AddActivityByDone", sender: Any.self)
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
        //todo activities
        case 0:
            returnValue = toDoActivities.count
            break
        //done activities
        case 1:
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
    
    static func getActivityID(activity:Reminder) -> Int{
        
        var counter = 0
        for currentActivity in SingletonActivity.sharedInstance.tasks{
            if(activity.reminderID == currentActivity.reminderID){
                return counter
            }
            counter = counter + 1
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DoneAndPostponedActivitiesTableViewCell", owner: self, options: nil)?.first as! DoneAndPostponedActivitiesTableViewCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true

        //undo button
        let undoButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "undo")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            //set status to toDo(=0)
            self.doneActivities[indexPath.row].status = 0
            self.toDoActivities.append(self.doneActivities[indexPath.row])
            self.doneActivities.remove(at: indexPath.row)
            self.controllerPlist.saveReminders()
            self.activitiesTableView.reloadData()
            return true
        }

        let calendar = Calendar.current
        
        let activity:Reminder
        
        if(activitiesSegment.selectedSegmentIndex == 0){
            activity = toDoActivities[indexPath.row]
        }else if(activitiesSegment.selectedSegmentIndex == 1){
            activity = doneActivities[indexPath.row]
        }else{
            activity = postponedActivities[indexPath.row]
        }
        
        //done button
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Done")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            //set status to done(=1)
            if(self.activitiesSegment.selectedSegmentIndex == 2){
                self.postponedActivities[indexPath.row].status = 1
                self.doneActivities.append(self.postponedActivities[indexPath.row])
                self.postponedActivities.remove(at: indexPath.row)
            }else if (self.activitiesSegment.selectedSegmentIndex == 0){
                self.toDoActivities[indexPath.row].status = 1
                self.doneActivities.append(self.toDoActivities[indexPath.row])
                self.toDoActivities.remove(at: indexPath.row)
            }
            self.controllerPlist.saveReminders()
            self.activitiesTableView.reloadData()
            return true
        }

        
        //postpone button
        let postponeButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Postpone")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            self.toDoActivities[indexPath.row].status = 2
            
            self.indexActivity = DoneAndPostponedActivitiesViewController.getActivityID(activity: activity)
            self.performSegue(withIdentifier: "GoToPostponeByDone", sender: Any.self)
            
            self.postponedActivities.append(self.toDoActivities[indexPath.row])
            self.toDoActivities.remove(at: indexPath.row)
            self.controllerPlist.saveReminders()
            tableView.reloadData()
            return true
        }
        
        //edit button
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.indexActivity = DoneAndPostponedActivitiesViewController.getActivityID(activity: activity)
            self.performSegue(withIdentifier: "EditActivity", sender: Any.self)
            
            return true
        }
        
        //delete button
        let deleteButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "delete")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            let getActivitityPosition = DoneAndPostponedActivitiesViewController.getActivityID(activity: activity)
            SingletonActivity.sharedInstance.tasks.remove(at: getActivitityPosition)
            self.toDoActivities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.controllerPlist.saveReminders()
            return true
        }
        
        
        switch activitiesSegment.selectedSegmentIndex {
        
        
        case 0:
            cell.activityLabel.text = activity.title
            cell.iconImage.image = UIImage(named: "clockIcon")
            cell.colorLabel.backgroundColor = activity.subject?.color
            cell.subjectLabel.text = activity.subject?.title
            
            let day = calendar.component(.day, from: activity.time)
            let month = calendar.component(.month, from: activity.time)
            let year = calendar.component(.year, from: activity.time)
            let hour = calendar.component(.hour, from: activity.time)
            let minutes = calendar.component(.minute, from: activity.time)
            
            cell.timeLabel.text = "\(day)/\(month)/\(year) -" + (CalendarViewController.maskTime(hour:hour, minutes:minutes))
            
            cell.leftButtons = [deleteButton, editButton]
            cell.leftSwipeSettings.transition = .border
            cell.rightButtons = [doneButton, postponeButton]
            cell.rightSwipeSettings.transition = .border
            
            break
        case 1:
            cell.activityLabel.text = activity.title
            cell.iconImage.image = UIImage(named: "check")
            cell.colorLabel.backgroundColor = activity.subject?.color
            cell.subjectLabel.text = activity.subject?.title
            
            let day = calendar.component(.day, from: activity.time)
            let month = calendar.component(.month, from: activity.time)
            let year = calendar.component(.year, from: activity.time)
            let hour = calendar.component(.hour, from: activity.time)
            let minutes = calendar.component(.minute, from: activity.time)
            
            cell.timeLabel.text = "\(day)/\(month)/\(year) -" + (CalendarViewController.maskTime(hour:hour, minutes:minutes))
            
            cell.rightButtons = [undoButton]
            cell.rightSwipeSettings.transition = .border
            
            break
        default:
            cell.colorLabel.backgroundColor = activity.subject?.color
            cell.subjectLabel.text = activity.subject?.title
            cell.activityLabel.text = activity.title
            cell.iconImage.image = UIImage(named: "clockIcon")
            
            let day = calendar.component(.day, from: activity.time)
            let month = calendar.component(.month, from: activity.time)
            let year = calendar.component(.year, from: activity.time)
            let hour = calendar.component(.hour, from: activity.time)
            let minutes = calendar.component(.minute, from: activity.time)
            
            cell.timeLabel.text = "\(day)/\(month)/\(year) -" + (CalendarViewController.maskTime(hour:hour, minutes:minutes))
            
            cell.rightButtons = [doneButton]
            cell.rightSwipeSettings.transition = .border
            cell.leftButtons = [editButton]
            cell.leftSwipeSettings.transition = .border
        }
        
        cell.colorLabel.clipsToBounds = true
        cell.colorLabel.layer.cornerRadius = 2.5
        
        return cell
    }


}
