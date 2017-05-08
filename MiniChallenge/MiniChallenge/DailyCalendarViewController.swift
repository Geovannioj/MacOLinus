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

    var passedText : String?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var extenseDay: UILabel!
    
    var passedDate : Date?
    var currentDate : Date?
    let formatter = DateFormatter()
    
//    @IBOutlet var calendarView: JTAppleCalendarView!


    
//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Passed text: \(passedText)")
        extenseDay.text = passedText
  
        
        
        //      setUpDailyCalendar()
  //      currentDate = passedDate
    }
    
    @IBAction func dismissScreen(){
        dismiss(animated: true, completion: nil)
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

