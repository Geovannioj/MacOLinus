//
//  CalendarViewController.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import JTAppleCalendar
import MGSwipeTableCell

let redColor = UIColor(red: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
let purpleColor = UIColor(colorLiteralRed: 0.4078, green: 0.4314, blue: 0.8784, alpha: 1)


class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var alertNotificationPositionConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertNotificationView: UIView!
    @IBOutlet weak var alertNotificationLabel: UILabel!
    
    @IBOutlet weak var calendarNavigationBar: UINavigationBar!
    @IBOutlet weak var appointmentOnDay: UILabel!

    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel : UILabel?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addActivityButton: UIButton!
    
    static var sendActivityToPostpone : Bool  = false
    
    //General Attributes
    let logo = UIImage(named: "Pengo.png")
    var selectedDayCell = DaysOfWeek.sunday
    var selectedDayText: String?
    let controlerPList = ControllerPList()
    
    //Activities TableView Attributes
    let cellReuseIdentifier = "ActivityTableViewCell"
    let cellSpacingHeight: CGFloat = 0.02
    var activities = [Reminder]()
    
    //Calenadar attributes
    var currentDate : NSDate? = nil
    let formatter = DateFormatter()
    var numberOfRows = 6
    
    //Data to be Passed to the edit screen
    var subjectTitle: String = ""
    var activityTitle: String = ""
    var activityTime: String = ""
    var sendActivity = Reminder()
    var indexActivity: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
        
        loadReminders()
        
        activities = getToDoAndPostponedActivities(activities: SingletonActivity.sharedInstance.tasks)
        activities = sortActivities()
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "DayActivityTableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "ActivityTableViewCell")
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.alertNotificationView.layer.borderWidth = 1
        self.alertNotificationView.layer.borderColor = redColor.cgColor
        self.alertNotificationView.layer.cornerRadius = 10
        
        self.alertNotificationPositionConstraint.constant -= self.view.bounds.width
        
        self.tabBarItem.image = UIImage(named: "Calendar Line")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: "Clendar Fill")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: redColor], for: .selected)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if CalendarViewController.sendActivityToPostpone {
            showAnimationMovedToPostPoned()
        }
    }

    func documentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    

    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Reminders.plist")
    }
    
    func loadReminders(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonActivity.sharedInstance.tasks = unarchiver.decodeObject(forKey: "Reminders") as! [Reminder]
            unarchiver.finishDecoding()
        }
        
    }

    func setUpCalendar(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        currentDate = NSDate()
        
        calendarView.visibleDates{ (visibleDates) in
            self.handleMonthAndYearText(from: visibleDates)
            self.moveCalendarToCurrentMonth()
            self.markCurrentDayOnCalendar()
        }
    }
    
    func moveCalendarToCurrentMonth(){
        calendarView.scrollToDate(currentDate! as Date)
    }
    
    func markCurrentDayOnCalendar(){
        calendarView.selectDates([currentDate! as Date])
    }
    
    func handleMonthAndYearText(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first?.date
        
        self.formatter.dateFormat = "MMMM yyyy"
        self.monthLabel?.text = self.formatter.string(from: date!)
    }

    
    //Funtion responsible for handling the text color on the calendar
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState){
        
        guard let currentCell = cell as? CalendarCell else { return }
        
        if currentCell.isSelected{
            currentCell.dateLabel?.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                currentCell.dateLabel?.textColor = UIColor(red: 0.9922, green: 0.4941, blue: 0.4941, alpha: 1.0)
            } else {
                currentCell.dateLabel?.textColor = UIColor(red: 0.9922, green: 0.4941, blue: 0.4941, alpha: 0.5)
            }
        }
    }
    
    func howManyEventsOnDay(date: Date) -> Int{
        
        formatter.timeStyle = .none
        
        var containsEvent = 0
        
        for activity in activities{
            
            if NSCalendar.current.compare(date, to: activity.time, toGranularity: .day) == ComparisonResult.orderedSame {
                
                if activity.status == 0 || activity.status == 2{
                     containsEvent += 1
                }
            }
        }
        
        return containsEvent
    }
    
    @IBAction func moveToNextMonth(){
        calendarView.scrollToSegment(SegmentDestination.next)
        calendarView.reloadData()
    }
    
    @IBAction func moveToPreviousMonth(){
        calendarView.scrollToSegment(SegmentDestination.previous)
        calendarView.reloadData()
    }
    
    @IBAction func addActivityAction(_ sender: Any) {
        performSegue(withIdentifier: "AddActivity", sender: Any?.self)
    }
 
    func handleAppointmentOnDayLabel(cell: CalendarCell, cellState: CellState, date: Date){
        
        let numberOfEventsOnDay = howManyEventsOnDay(date: date)

        if numberOfEventsOnDay > 0 {

            cell.appointmentOnDay.isHidden = false
        } else {
            
            cell.appointmentOnDay.isHidden = true
        }
        
    }
    
    func sortActivities() -> [Reminder]{
        
        var sortedArray : [Reminder] = []
        sortedArray = activities.sorted(by: { $0.time.compare($1.time) == ComparisonResult.orderedAscending})
        
        return sortedArray
    }
    
    func getToDoAndPostponedActivities(activities: [Reminder]) -> [Reminder]{
        
        var toDoActivities: [Reminder] = []
        
        for activity in activities{
            
            //get toDo or postponed Activities(status = 0 || status == 2)
            if(activity.status == 0 || activity.status == 2){
                toDoActivities.append(activity)
            }
        }
        
        return toDoActivities
    }
    
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
    
    static func maskTime(hour: Int, minutes: Int) -> String{
        
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
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("ActivityTableViewCell", owner: self, options: nil)?.first as! ActivityTableViewCell
        
        let activity = activities[indexPath.row]
        
        let editButton = MGSwipeButton(title:"            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit")!)){
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.indexActivity = indexPath.row
            self.performSegue(withIdentifier: "EditActivityController", sender: tableView)
            
            return true
        }
        
        //done button
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Done")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.showAnimationMovedToDone()

            self.activities[indexPath.row].status = 1
            self.activities.remove(at: indexPath.row)
            self.controlerPList.saveReminders()
            self.calendarView.reloadData()
            tableView.reloadData()
            return true
        }
        

        //delete button
        let deleteButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "delete")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            let deletingAlert = UIAlertController(title: "Excluindo atividade", message: "você deseja excluir a atividade: \(activity.title)", preferredStyle: .alert)
            
            let deleteButton = UIAlertAction(title: "Deletar", style: UIAlertActionStyle.cancel, handler: { action in
                self.activities.remove(at: indexPath.row)
                SingletonActivity.sharedInstance.tasks.remove(at: indexPath.row)
                let indexPaths = [indexPath]
                tableView.deleteRows(at: indexPaths, with: .automatic)
                self.controlerPList.saveReminders()
                
                self.calendarView.reloadData()
            })
            
            let cancelButton = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                //Do nothing
            })
            
            deletingAlert.addAction(deleteButton)
            deletingAlert.addAction(cancelButton)
            
            
            self.present(deletingAlert, animated: true, completion: nil)
            
            return true
        }

        //postpone button
        let postponeButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "Postpone")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            self.activities[indexPath.row].status = 2
            
            self.indexActivity = DoneAndPostponedActivitiesViewController.getActivityID(activity: activity)
            self.performSegue(withIdentifier: "GoToPostpone", sender: Any.self)
            
            self.controlerPList.saveReminders()
            tableView.reloadData()
            return true
        }
        
        let date = activity.time
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        cell.activityName.text = activity.title
        cell.activitySubject.text = activity.subject?.title
        cell.activityHour.text = CalendarViewController.maskTime(hour: hour, minutes: minutes)
        cell.dayLabel.text = String(day)
        cell.monthLabel.text = String(CalendarViewController.selectMonthText(month: month))
        cell.subjectColor.backgroundColor = activity.subject?.color
        
        // add border and color
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.subjectColor.clipsToBounds = true
        cell.subjectColor.layer.cornerRadius = 2.5
        
        
        cell.leftButtons = [deleteButton, editButton]
        cell.leftSwipeSettings.transition = .border
        cell.rightButtons = [doneButton, postponeButton]
        cell.rightSwipeSettings.transition = .border
        
        
        return cell

    }
    
   static func selectMonthText(month: Int) -> String {
        
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Fev"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Ago"
        case 9:
            return "Set"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
    
    func showAnimationMovedToDone(){
        
        self.alertNotificationLabel.text = "Movida para Feitos"
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.alertNotificationPositionConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2.0, animations: {
            self.alertNotificationPositionConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showAnimationMovedToPostPoned(){
        
        self.alertNotificationLabel.text = "Movida para Adiados"
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.alertNotificationPositionConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2.0, animations: {
            self.alertNotificationPositionConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        CalendarViewController.sendActivityToPostpone = false
    }
}


/*
 * This extensions contains the methods responsible for configuring the TableView of next
 * Activities.
 */

//extension CalendarViewController : UITableViewDataSource, UITableViewDelegate {

//}
/*
 * The two extensions below were created to manage the calendarView.
 * First contains the calendar configuration code
 * Second contains the calendar constructors and default responses to each interaction
 */

extension CalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        
        
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!,
                                                 endDate: endDate!,
                                                 numberOfRows: numberOfRows,
                                                 generateOutDates: OutDateCellGeneration.tillEndOfRow)
        
        
        self.heightConstraint.constant = numberOfRows == 1 ? 50 : 265
        
        return parameters
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.dateLabel?.text = cellState.text
        cell.selectedCell?.layer.cornerRadius = 12
        cell.appointmentOnDay.layer.masksToBounds = true
        cell.appointmentOnDay.layer.cornerRadius = 3.5
        
        if cell.isSelected {
            cell.selectedCell?.isHidden = false
            cell.appointmentOnDay.backgroundColor = UIColor.white
        } else {
            cell.selectedCell?.isHidden = true
            cell.appointmentOnDay.backgroundColor = redColor
        }
        
        handleCellTextColor(cell: cell, cellState: cellState)
        handleAppointmentOnDayLabel(cell: cell, cellState: cellState, date: date)
        
        return cell
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else { return }
        selectedCell.selectedCell?.isHidden = false
        
        handleCellTextColor(cell: cell, cellState: cellState)
        
        selectedDayCell = DaysOfWeek(rawValue: cellState.day.rawValue)!
        
        switch selectedDayCell {
            case .sunday:
                selectedDayText = "Domingo, "
            case .monday:
                selectedDayText = "Segunda-Feira, "
            case.tuesday:
                selectedDayText = "Terça-Feira, "
            case .wednesday:
                selectedDayText = "Quarta-Feira, "
            case .thursday:
                selectedDayText = "Quinta-Feira, "
            case .friday:
                selectedDayText = "Sexta-Feira, "
            case .saturday:
                selectedDayText = "Sábado, "
        }
        
        performSegue(withIdentifier: "goToDailyCalendar", sender: date)
        
        calendarView.scrollToDate(date)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDailyCalendar" {
                
            SingletonPassedDate.sharedInstance.passedText = selectedDayText!
                
            self.formatter.dateStyle = .long
                
            SingletonPassedDate.sharedInstance.passedText.append(formatter.string(from: sender as! Date))
                
            SingletonPassedDate.sharedInstance.passedDate = (sender as? Date)!
        }else if segue.identifier == "EditActivityController"{
            
            if let goToEditScreen = segue.destination as? EditActivityController{

                goToEditScreen.indexActivityToEdit = indexActivity

          }
        }else if segue.identifier == "GoToPostpone"{
            if let goToPostpone = segue.destination as? DatePickViewController{
                goToPostpone.indexActivityToEdit = self.indexActivity
                goToPostpone.segueRecived = segue.identifier!
            }
        }else if segue.identifier == "AddActivity"{
            if let goToAddActivity = segue.destination as? AddTitleController{
                goToAddActivity.segueRecived = segue.identifier!
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else { return }
        selectedCell.selectedCell?.isHidden = true
        
        handleCellTextColor(cell: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        handleMonthAndYearText(from: visibleDates)
        calendarView.reloadData()
    }
}


