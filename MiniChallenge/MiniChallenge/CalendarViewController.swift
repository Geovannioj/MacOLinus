//
//  CalendarViewController.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 25/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel : UILabel?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    let cellReuseIdentifier = "ActivityTableViewCell"
    let cellSpacingHeight: CGFloat = 0
    
    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)

    
    var currentDate : NSDate? = nil
    let formatter = DateFormatter()
    var numberOfRows = 6
    
    var numberOfEvents : Int = 0
    let distanceBetweenCells = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func creatingTestDataToDisplayOnTableView() { //FUNCAO TESTE
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func shrinkCalendar(animationDuration: Float){
        
        numberOfRows = 1
        
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
            self.calendarView.frame = CGRect(x: 0, y: 90, width: self.calendarView.frame.width, height: 50)
            self.calendarView.reloadData()
        })
    }
    
    func expandCalendar(animationDuration: Float){
        
        numberOfRows = 6
        
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
            self.calendarView.frame = CGRect(x: 0, y: 90, width: self.calendarView.frame.width, height: 265)
            self.calendarView.reloadData(with: self.currentDate as Date?)
        })
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
    
    @IBAction func moveToNextMonth(){
        calendarView.scrollToSegment(SegmentDestination.next)
        calendarView.reloadData()
    }
    
    @IBAction func moveToPreviousMonth(){
        calendarView.scrollToSegment(SegmentDestination.previous)
        calendarView.reloadData()
    }
    
    @IBAction func expandCalendarThroughBackButton(){
        
        expandCalendar(animationDuration: 0.5)
    }

}

/*
 * This extensions contains the methods responsible for configuring the TableView of next
 * Activities.
 */

extension CalendarViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
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
        
        let cell = Bundle.main.loadNibNamed("ActivityTableViewCell", owner: self, options: nil)?.first as! ActivityTableViewCell
        
        // add border and color
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
    }
}

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
        cell.selectedCell?.layer.cornerRadius = 20
        cell.currentDayCell?.layer.cornerRadius = 12
        
        if cell.isSelected {
            cell.selectedCell?.isHidden = false
        } else {
            cell.selectedCell?.isHidden = true
        }
        
        handleCellTextColor(cell: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: NSDate, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.currentDayCell?.layer.cornerRadius = 12
        cell.currentDayCell?.isHidden = false
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else { return }
        selectedCell.selectedCell?.isHidden = false
        
        handleCellTextColor(cell: cell, cellState: cellState)
        
        
        if numberOfRows == 6 {
            shrinkCalendar(animationDuration: 0.2)
        }
        
        performSegue(withIdentifier: "goToDailyCalendar", sender: date)
        
        calendarView.scrollToDate(date)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDailyCalendar" {
            
            if let destination = segue.destination as? DailyCalendarViewController {
                
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


