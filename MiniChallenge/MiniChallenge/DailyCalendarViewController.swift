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
    
    
    @IBAction func AddActivityBtn(_ sender: Any) {
        performSegue(withIdentifier: "AddActivityByDaily", sender: Any.self)
    }
    @IBOutlet weak var activitiesTableView: UITableView!
    var passedText : String?
    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
//    @IBOutlet var calendarView: JTAppleCalendarView!
//    @IBOutlet var monthLabel: UILabel?
    
//    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var extenseDay: UILabel!
    
    var indexActivity = -1
    var passedDate : Date?
    var currentDate : Date?
    let formatter = DateFormatter()
//    @IBOutlet var calendarView: JTAppleCalendarView!

//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passedText = SingletonPassedDate.sharedInstance.passedText
        passedDate = SingletonPassedDate.sharedInstance.passedDate
        extenseDay.text = passedText
        
        checkActivitiesOnDay(activities: SingletonActivity.sharedInstance.tasks)
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
    
//    func setUpDailyCalendar(){
//        calendarView.minimumLineSpacing = 0
//        calendarView.minimumInteritemSpacing = 0
//        
//        calendarView.visibleDates{ (visibleDates) in
////            self.handleMonthAndYearText(from: visibleDates)
//            self.moveCalendarToCurrentMonth()
//            self.markCurrentDayOnCalendar()
//        }
//    }
    
//    func handleMonthAndYearText(from visibleDates: DateSegmentInfo){
//        let date = visibleDates.monthDates.first?.date
//        
//        self.formatter.dateFormat = "MMMM yyyy"
//        self.monthLabel?.text = self.formatter.string(from: date!)
//    }
    
//    func moveCalendarToCurrentMonth(){
//        calendarView.scrollToDate(currentDate! as Date)
//     //   calendarView.scrollToHeaderForDate(currentDate as! Date)
//    }
//    
//    func markCurrentDayOnCalendar(){
//        calendarView.selectDates([currentDate! as Date])
//    }
    
//    
//    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState){
//        
//        guard let currentCell = cell as? CalendarCell else { return }
//        
//        if currentCell.isSelected {
//            //set current day color to red
//            currentCell.dateLabel?.textColor = UIColor(red: 0.9922, green: 0.4941, blue: 0.4941, alpha: 1)
//        } else {
//            if cellState.dateBelongsTo == .thisMonth {
//                currentCell.dateLabel?.textColor = UIColor.white
//            } else {
//                currentCell.dateLabel?.textColor = UIColor.gray
//            }
//        }
//    }
}

//extension DailyCalendarViewController: JTAppleCalendarViewDelegate {
//    
//    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//    
//        formatter.dateFormat = "yyyy MM dd"
//        formatter.locale = Calendar.current.locale
//        formatter.timeZone = Calendar.current.timeZone
//        
//        
//        let startDate = formatter.date(from: "2017 01 01")
//        let endDate = formatter.date(from: "2018 12 31")
//        
//        let parameters = ConfigurationParameters(startDate: startDate!,
//                                                 endDate: endDate!,
//                                                 numberOfRows: 1)
//        
//        return parameters
//    }
//    
//}
//
//extension DailyCalendarViewController: JTAppleCalendarViewDataSource {
//    
//    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
//        
//        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
//        
//      //  cell.dateLabel?.textColor = UIColor(red: 0.9922, green: 0.4941, blue: 0.4941, alpha: 1.0)
//        
//        cell.dateLabel?.text = cellState.text
//        cell.selectedCell?.layer.cornerRadius = 12
//        
//        if cell.isSelected {
//            cell.selectedCell?.isHidden = false
//        } else {
//            cell.selectedCell?.isHidden = true
//        }
//        
//        handleCellTextColor(cell: cell, cellState: cellState)
//        
//        return cell
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        
//        guard let selectedCell = cell as? CalendarCell else { return }
//        
//        selectedCell.selectedCell?.isHidden = false
//        
//        handleCellTextColor(cell: cell, cellState: cellState)
//    }
//    
//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//
//        guard let selectedCell = cell as? CalendarCell else { return }
//        
//        selectedCell.selectedCell?.isHidden = true
//        
//        handleCellTextColor(cell: cell, cellState: cellState)
//        
//    }
//    
//}

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
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "done")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
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
}

