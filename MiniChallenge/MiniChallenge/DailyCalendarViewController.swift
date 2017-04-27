//
//  DailyCalendarViewController.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 27/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DailyCalendarViewController: UIViewController {

    @IBOutlet var calendarView: JTAppleCalendarView!
//    @IBOutlet var monthLabel: UILabel?
    
    var currentDate : NSDate?
    
    let formatter = DateFormatter()
    
//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDailyCalendar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpDailyCalendar(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        currentDate = NSDate()
        
        calendarView.visibleDates{ (visibleDates) in
//            self.handleMonthAndYearText(from: visibleDates)
            self.moveCalendarToCurrentMonth()
            self.markCurrentDayOnCalendar()
        }
    }
    
//    func handleMonthAndYearText(from visibleDates: DateSegmentInfo){
//        let date = visibleDates.monthDates.first?.date
//        
//        self.formatter.dateFormat = "MMMM yyyy"
//        self.monthLabel?.text = self.formatter.string(from: date!)
//    }
    
    func moveCalendarToCurrentMonth(){
        calendarView.scrollToDate(currentDate! as Date)
    }
    
    func markCurrentDayOnCalendar(){
        calendarView.selectDates([currentDate! as Date])
    }
    
    
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState){
        
        guard let currentCell = cell as? CalendarCell else { return }
        
        if currentCell.isSelected{
            //RED
            currentCell.dateLabel?.textColor = UIColor(red: 0.9922, green: 0.4941, blue: 0.4941, alpha: 1.0)
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                currentCell.dateLabel?.textColor = UIColor(red: 0.9922, green: 0.4941, blue: 0.4941, alpha: 1.0)
            } else {
                currentCell.dateLabel?.textColor = UIColor.gray
            }
        }
    }
}

extension DailyCalendarViewController: JTAppleCalendarViewDelegate {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        
        
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!,
                                                 endDate: endDate!,
                                                 numberOfRows: 1,
                                                 generateOutDates: OutDateCellGeneration.tillEndOfRow)
        
        return parameters
    }
    
}

extension DailyCalendarViewController: JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.dateLabel?.text = cellState.text
        cell.selectedCell?.layer.cornerRadius = 12
        cell.currentDayCell?.layer.cornerRadius = 12
        
        if cell.isSelected {
            cell.selectedCell?.isHidden = false
        } else {
            cell.selectedCell?.isHidden = true
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else { return }
        
        selectedCell.selectedCell?.isHidden = false
        
        handleCellTextColor(cell: cell, cellState: cellState)
        
        calendarView.scrollToDate(date)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {

        guard let selectedCell = cell as? CalendarCell else { return }
        
        selectedCell.selectedCell?.isHidden = false
        
    }
    
}
