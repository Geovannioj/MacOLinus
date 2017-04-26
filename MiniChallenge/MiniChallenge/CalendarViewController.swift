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
    
    var currentDate : NSDate? = nil
    let formatter = DateFormatter()
    var numberOfRows = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
        
        
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
        self.monthLabel?.text = self.formatter.string(from: date!)
    }
    
    @IBAction func moveToNextMonth(){
        calendarView.scrollToSegment(SegmentDestination.next)
    }
    
    @IBAction func moveToPreviousMonth(){
        calendarView.scrollToSegment(SegmentDestination.previous)
    }
    
    @IBAction func changeLayout(){
        
        let animatingDuration = 0.3
        
        if numberOfRows == 6 {
            numberOfRows = 1
            
            UIView.animate(withDuration: animatingDuration - 0.1, animations: {
                self.calendarView.frame = CGRect(x: 0, y: 50, width: self.calendarView.frame.width, height: 50)
                self.calendarView.reloadData()
            })
            
        } else {
            numberOfRows = 6
            
            UIView.animate(withDuration: animatingDuration, animations: {
                self.calendarView.frame = CGRect(x: 0, y: 50, width: self.calendarView.frame.width, height: 265)
                self.calendarView.reloadData()
            })
            
        }
        
        markCurrentDayOnCalendar()
        calendarView.scrollToDate(currentDate! as Date, animateScroll: false)
    }
    
    //Funtion responsible for handling the text color on the calendar
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState){
        
        guard let currentCell = cell as? CalendarCell else { return }
        
        if currentCell.isSelected{
            currentCell.dateLabel?.textColor = UIColor.green
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                currentCell.dateLabel?.textColor = UIColor.black
            } else {
                currentCell.dateLabel?.textColor = UIColor.gray
            }
        }
    }
    
//    func handleSelectedCellView(cell: JTAppleCell, cellState: CellState){
//        
//        guard let currentCell = cell as? CalendarCell else { return }
//        
//        if currentCell.isSelected {
//            currentCell.selectedCell?.isHidden = false
//        } else {
//            currentCell.selectedCell?.isHidden = true
//        }
//    }

}

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
        
        return parameters
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.dateLabel?.text = cellState.text
        cell.selectedCell?.layer.cornerRadius = 12
        cell.currentDayCell?.layer.cornerRadius = 12
        
        if (currentDate?.isEqual(to: date))!{
            cell.currentDayCell?.isHidden = false
        }
        
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
        
        changeLayout()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else { return }
        selectedCell.selectedCell?.isHidden = true
        
        handleCellTextColor(cell: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        handleMonthAndYearText(from: visibleDates)
    }
}
