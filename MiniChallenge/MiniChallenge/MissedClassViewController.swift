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

    @IBOutlet weak var missedClassesLb: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let currentDate = NSDate()
    
    var missedClassesTest = [NSDate]()
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        calendarView.minimumInteritemSpacing = 0
        calendarView.minimumLineSpacing = 0
        
        formatter.dateFormat = "yyyy MM dd"
        missedClassesTest.append(formatter.date(from: "2017 01 15")! as NSDate)
        missedClassesTest.append(formatter.date(from: "2017 01 22")! as NSDate)
        missedClassesLb.text = String(missedClassesTest.count)
    }
    
    func checkIfHasMisseClassOnDay(date: Date) -> Bool{
      
        var hasEvent = false
        
        for index in 0..<missedClassesTest.count {
            
            if Calendar.current.compare(date, to: missedClassesTest[index] as Date, toGranularity: .day) == .orderedSame {
                
                hasEvent = true
            }
        }
        
        return hasEvent
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
        
        if checkIfHasMisseClassOnDay(date: date){
            
            cell.selectedCell.isHidden = false
            cell.selectedCell.layer.cornerRadius = 15
        }
        else {
            cell.selectedCell.isHidden = true
        }
        
        cell.dateLabel?.text = cellState.text
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let selectedCell = cell as? CalendarCell else { return }
        
        formatter.dateFormat = "MMM d, yyyy"
        
        let dataToDisplay = formatter.string(from: date)
        
        selectedCell.selectedCell?.isHidden = false
        selectedCell.selectedCell.layer.cornerRadius = 15
        
        let addAlert = UIAlertController(title: "Adicionar falta", message: "você deseja adicionar uma falta no dia \(dataToDisplay)", preferredStyle: .alert)
   
        let addAction = UIAlertAction(title: "Adicionar", style: .default, handler: {
                action in
                self.missedClassesTest.append(date as NSDate)
                self.missedClassesLb.text = String(self.missedClassesTest.count)
                self.calendarView.reloadData()
                print(self.missedClassesTest)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: {
                action in
                selectedCell.selectedCell.isHidden = true
            })
        
        addAlert.addAction(addAction)
        addAlert.addAction(cancelAction)
        
       present(addAlert, animated: true, completion: nil)
        
    }
}
