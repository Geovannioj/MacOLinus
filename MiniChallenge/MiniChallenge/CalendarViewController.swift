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

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var calendarNavigationBar: UINavigationBar!
    @IBOutlet weak var appointmentOnDay: UILabel!

    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel : UILabel?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    //General Attributes
    let logo = UIImage(named: "Pengo.png")
    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
    var selectedDayCell = DaysOfWeek.sunday
    var selectedDayText: String?
    let controlerPList = ControllerPList()
    
    //Activities TableView Attributes
    let cellReuseIdentifier = "ActivityTableViewCell"
    let cellSpacingHeight: CGFloat = 0.02
    //var activities = [Reminder]()
    
    //Calenadar attributes
    var currentDate : NSDate? = nil
    let formatter = DateFormatter()
    var numberOfRows = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
        
        
        loadReminders()
        //obtainActivites()
        
        
        let nib = UINib(nibName: "DayActivityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ActivityTableViewCell")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        print(documentsDirectory())

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func saveReminders(){
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SingletonActivity.sharedInstance.tasks, forKey: "Reminders")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
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
        print(String(describing: date))
        self.monthLabel?.text = self.formatter.string(from: date!)
    }

//    func shrinkCalendar(animationDuration: Float){
//        
//        numberOfRows = 1
//        
//        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
//            self.calendarView.frame = CGRect(x: 0, y: 90, width: self.calendarView.frame.width, height: 50)
//            self.calendarView.reloadData()
//        })
//    }
    
//    func expandCalendar(animationDuration: Float){
//        
//        numberOfRows = 6
//        
//        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
//            self.calendarView.frame = CGRect(x: 0, y: 90, width: self.calendarView.frame.width, height: 265)
//            self.calendarView.reloadData(with: self.currentDate as Date?)
//        })
//    }
    
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
        
        for activity in SingletonActivity.sharedInstance.tasks{
            
            if NSCalendar.current.compare(date, to: activity.time, toGranularity: .day) == ComparisonResult.orderedSame {
                
                containsEvent += 1
                print(date)
            }
        }
        
        print(containsEvent)
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
    
    func handleAppointmentOnDayLabel(cell: CalendarCell, cellState: CellState, date: Date){
        
        let numberOfEventsOnDay = howManyEventsOnDay(date: date)

        if numberOfEventsOnDay > 0 {

            cell.appointmentOnDay.isHidden = false
        } else {
            
            cell.appointmentOnDay.isHidden = true
        }
        
    }
    
    
//    func obtainActivites(){
//        activities = SingletonActivity.sharedInstance.tasks
//    }
    
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonActivity.sharedInstance.tasks.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    //delete the tableRow
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        SingletonActivity.sharedInstance.tasks.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        controlerPList.saveReminders()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //DO SHIT
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
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let editButton = MGSwipeButton(title:"          ", backgroundColor: UIColor(patternImage: UIImage(named: "edit.png")!)){
            (sender: MGSwipeTableCell!) -> Bool in
            
            return true
        }

        let cell = Bundle.main.loadNibNamed("ActivityTableViewCell", owner: self, options: nil)?.first as! ActivityTableViewCell
        
        let activity = SingletonActivity.sharedInstance.tasks[indexPath.row]
        
        
        let date = activity.time
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        cell.activityName.text = activity.title
        cell.activitySubject.text = activity.subject.title
        cell.activityHour.text = "\(hour):\(minutes)"
        cell.dayLabel.text = String(day)
        cell.monthLabel.text = String(selectMonthText(month: month))
        
        // add border and color
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        cell.leftButtons = [editButton]
        cell.leftSwipeSettings.transition = .border
        
        return cell
    }
}

func selectMonthText(month: Int) -> String {
    
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
        
        
//        if numberOfRows == 6 {
//            shrinkCalendar(animationDuration: 0.2)
//        }
        
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
            
            if let destination = segue.destination as? DailyCalendarViewController {
                
                destination.passedText = selectedDayText
                
                self.formatter.dateStyle = .long
                
                destination.passedText?.append(formatter.string(from: sender as! Date))
                
                print("Data enviada \(String(describing: destination.passedText))")
                
                destination.passedDate = sender as? Date
                print("Sent date: \(String(describing: sender))")
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


