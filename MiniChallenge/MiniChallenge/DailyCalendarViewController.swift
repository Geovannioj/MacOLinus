//
//  DailyCalendarViewController.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 27/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import JTAppleCalendar
import MGSwipeTableCell

class DailyCalendarViewController: UIViewController {

    var activitiesOnDay = [Reminder]()
    let controllerPlist = ControllerPList()
    
    @IBOutlet weak var trailingAlertNotificationConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertNoticationView: UIView!
    @IBOutlet weak var alertNoticationLabel: UILabel!
    
    static var sentToPostPoned : Bool = false
    
    @IBAction func AddActivityBtn(_ sender: Any) {
        performSegue(withIdentifier: "AddActivityByDaily", sender: Any.self)
    }
    @IBOutlet weak var activitiesTableView: UITableView!
    var passedText : String?
    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
    @IBOutlet weak var extenseDay: UILabel!
    
    var indexActivity = -1
    var passedDate : Date?
    var currentDate : Date?
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passedText = SingletonPassedDate.sharedInstance.passedText
        passedDate = SingletonPassedDate.sharedInstance.passedDate
        extenseDay.text = passedText
        
        checkActivitiesOnDay(activities: SingletonActivity.sharedInstance.tasks)
        
        trailingAlertNotificationConstraint.constant += view.bounds.width
        alertNoticationView.layer.borderWidth = 1
        alertNoticationView.layer.borderColor = redColor.cgColor
        alertNoticationView.layer.cornerRadius = 10
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if DailyCalendarViewController.sentToPostPoned {
            showMovedAnimation("Movida para Adiados")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddActivityByDaily"{
            if let goToReminders = segue.destination as? AddTitleController{
                goToReminders.segueRecived = segue.identifier!
            }
        }else if segue.identifier == "GoToPostponeByDaily"{
            if let goToPostpone = segue.destination as? DatePickViewController{
                goToPostpone.segueRecived = segue.identifier!
                goToPostpone.indexActivityToEdit = self.indexActivity
            }
        }else if segue.identifier == "EditActivityByDaily"{
            if let goToEdit = segue.destination as? EditActivityController{
                goToEdit.segueReceived = segue.identifier!
                goToEdit.indexActivityToEdit = self.indexActivity
            }
        }
    }
    
    func checkActivitiesOnDay(activities: [Reminder]){
    
        for activity in activities{
            if NSCalendar.current.compare(passedDate!, to: activity.time, toGranularity: .day) == ComparisonResult.orderedSame {
    
                if(activity.status == 0 || activity.status == 2){
                    activitiesOnDay.append(activity)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DailyCalendarViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesOnDay.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DayActivityTableViewCell", owner: self, options: nil)?.first as! DayActivityTableViewCell

        let correspondentActivity = activitiesOnDay[indexPath.row]
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: correspondentActivity.time)
        let minutes = calendar.component(.minute, from: correspondentActivity.time)
        
        cell.activityLabel.text = correspondentActivity.title
        cell.subjectLabel.text = correspondentActivity.subject?.title
        cell.colorLabel.backgroundColor = correspondentActivity.subject?.color
        cell.timeLabel.text = CalendarViewController.maskTime(hour: hour, minutes: minutes)
        cell.clockImage.image = UIImage(named: "clockIcon")
        
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.colorLabel.clipsToBounds = true
        cell.colorLabel.layer.cornerRadius = 2.5
        
        //postpone button
        let postponeButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Postpone")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            DailyCalendarViewController.sentToPostPoned = true
            
            self.activitiesOnDay[indexPath.row].status = 2
            
            self.indexActivity = DoneAndPostponedActivitiesViewController.getActivityID(activity: correspondentActivity)
            self.performSegue(withIdentifier: "GoToPostponeByDaily", sender: Any.self)
            
            self.controllerPlist.saveReminders()
            tableView.reloadData()
            
            return true
        }
        
        //edit button
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.indexActivity = DoneAndPostponedActivitiesViewController.getActivityID(activity: correspondentActivity)
            self.performSegue(withIdentifier: "EditActivityByDaily", sender: Any.self)
            return true
        }
        
        //done button
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Done")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            
            self.showMovedAnimation("movida para Feitos")
            //self.showMovedToDoneAnimation()
            
            self.activitiesOnDay[indexPath.row].status = 1
            self.activitiesOnDay.remove(at: indexPath.row)
            self.controllerPlist.saveReminders()
            tableView.reloadData()
            return true
        }
        
        //configure left and right buttons
        cell.leftButtons = [postponeButton, editButton]
        cell.leftSwipeSettings.transition = .border
        cell.rightButtons = [doneButton]
        cell.rightSwipeSettings.transition = .border
        
        return cell
    }
    
    func showMovedAnimation(_ textToLabel : String) {
        
        self.alertNoticationLabel.text = textToLabel
        
        UIView.animate(withDuration: 1, delay: 0.0, animations: {
            
            self.trailingAlertNotificationConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2.0, animations: {
            self.trailingAlertNotificationConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        if textToLabel == "Movida para Adiados" {
            DailyCalendarViewController.sentToPostPoned = false
        }
        
    }
    
    func showMovedToPostPonedAnimation(){
        
        self.alertNoticationLabel.text = "Movida para Adiados"
        
        UIView.animate(withDuration: 1, delay: 0.0, animations: {
            self.trailingAlertNotificationConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2.0 ,animations: {
            self.trailingAlertNotificationConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        DailyCalendarViewController.sentToPostPoned = false
    }
    
    func showMovedToDoneAnimation(){
        
        self.alertNoticationLabel.text = "Movida para feitos"
        
        UIView.animate(withDuration: 1, delay: 0.0, animations: {
            
            self.trailingAlertNotificationConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2.0, animations: {
            self.trailingAlertNotificationConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

