//
//  ShowSubjectsActivity.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 18/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ShowSubjectsActivity: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var subjectsActivityTableView: UITableView!
    @IBOutlet weak var subjectNameLbl: UILabel!
    @IBOutlet weak var subjectColorLBl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var subjectReceived:Subject?
    var subjectsActivity: [Reminder] = []
    var receivedArray: [Reminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectsActivity = receivedArray
        
        subjectNameLbl.text = subjectReceived?.title
        subjectColorLBl.backgroundColor = subjectReceived?.color
        
        self.subjectColorLBl.clipsToBounds = true
        self.subjectColorLBl.layer.cornerRadius = 8
        
        subjectsActivityTableView.delegate = self
        subjectsActivityTableView.dataSource = self
        
        self.subjectsActivityTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath)
//        let activity = subjectsActivity[indexPath.row]
//        
//        let activityName = cell?.viewWithTag()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsActivity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activities", for: indexPath)
       
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor =  UIColor(red: 0.2353, green:0.9020, blue:0.7686, alpha: 1.0).cgColor

        let activity = subjectsActivity[indexPath.row]
        
        let activityNameLabel = cell.viewWithTag(30) as! UILabel
        let activityTimeLabel = cell.viewWithTag(31) as! UILabel
        let warningLbl = cell.viewWithTag(23) as! UILabel
        
        warningLbl.isHidden = true
        
        activityNameLabel.text = activity.title
        
        let subjectActivity = activity.time
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: subjectActivity)
        let minute = calendar.component(.minute, from: subjectActivity)
        let day = calendar.component(.day, from: subjectActivity)
        let month = calendar.component(.month, from: subjectActivity)
        
        let castMonthToString = CalendarViewController.selectMonthText(month: month)
        let castDayToString = String(day)
        
        
        let activityTime = CalendarViewController.maskTime(hour: hour, minutes: minute)
        
        let completeTime = ("\(castDayToString) \(castMonthToString)  \(activityTime)")
        activityTimeLabel.text = completeTime
        
        if activity.time < Date(){
            warningLbl.isHidden = false
        }
        
        return cell

    }
    
    @IBAction func SegmentControlChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 2 {
    
            performSegue(withIdentifier: "SubjectFaults", sender: Any?.self)
        } else if segmentControl.selectedSegmentIndex == 1 {
    
            performSegue(withIdentifier: "HomeNotes", sender: Any?.self)
    
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("---------------")
        print(segue.identifier)
        print("---------------")
        if segue.identifier == "SubjectFaults"{
            if let nextScreen = segue.destination as? SubjectFaultsViewController {
                nextScreen.filteredActivities = self.receivedArray
                nextScreen.subjectReceived = self.subjectReceived
            }
        }else if segue.identifier == "HomeNotes"{
            if let nextScreen = segue.destination as? HomeNotesViewController {
                
                nextScreen.subjectReceived = self.subjectReceived
                nextScreen.filteredActivities = self.receivedArray
            }
        } else if segue.identifier == "BackToSubjectsHome" {
            if let nextScreen = segue.destination as? HomeSubject {
                nextScreen.filteredActivityArray = self.receivedArray
            }
        }else if segue.identifier == "BackToCalendar"{
            CalendarViewController.pushedFromHomeSubject = true
        }
        
    }

    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        performSegue(withIdentifier: "BackToCalendar", sender: Any?.self)
        
    }
}
