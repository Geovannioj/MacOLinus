//
//  MissedClassViewController.swift
//  MiniChallenge
//
//  Created by Gabriel Rodrigues on 14/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import JTAppleCalendar

class MissedClassViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let currentDate = NSDate()
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.minimumInteritemSpacing = 0
        calendarView.minimumLineSpacing = 0 

    }
}

extension MissedClassViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!, numberOfRows: 6, generateOutDates: OutDateCellGeneration.tillEndOfRow)
        
        return parameters
    }
}

extension MissedClassViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "MissedClassCell", for: indexPath) as! CalendarCell
        
        if NSCalendar.current.compare(date, to: currentDate as Date, toGranularity: Calendar.Component.day) == ComparisonResult.orderedSame {
            cell.dateLabel?.textColor = UIColor.red
        }
        
//        if checkIfHasMisseClassOnDay() == true {
            
            cell.selectedCell.isHidden = false
            cell.selectedCell.layer.cornerRadius = 15
            
//        }
        
        cell.dateLabel?.text = cellState.text
        
        return cell
    }
}
