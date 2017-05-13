//
//  EditActivityController.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class EditActivityController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var cellText = ["Matéria", "Tarefa", "Horário"]
    var dataPassed = [String]()
    var activityPassed = Reminder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        performSegue(withIdentifier: "GoToCalendar", sender: Any?.self)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        
        performSegue(withIdentifier: "BackToCalendar", sender: Any?.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskAtributes", for: indexPath)
        
        let txt = cell.viewWithTag(20) as! UILabel
        txt.text = cellText[indexPath.row]
        
        let recivedData = cell.viewWithTag(21) as! UILabel
        recivedData.text = dataPassed[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            print("Row0")
            self.performSegue(withIdentifier: "ChooseSubjectController", sender: tableView)
        
        }else if indexPath.row == 1{
            print("Row1")
            performSegue(withIdentifier: "Reminders", sender: Any?.self)
        
        }else if indexPath.row == 2{
            print("Row2")
            performSegue(withIdentifier: "DatePickViewController", sender: Any?.self)
                
        }

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToAddSubject" {
            
            if let toAddSubject = segue.destination as? SubjectViewController{
                
                toAddSubject.segueData = segue.identifier
                
            }
            
        }else if segue.identifier == "ChooseSubjectController" {
            
            if let goToChooseSubject = segue.destination as? ChooseSubjectController{
                
            }
        
        }else if segue.identifier == "Reminders" {
            
            if let gotToReminderAddTitle = segue.destination as? AddTitleController{
                
            }
            
        }else if segue.identifier == "DatePickViewController" {
            
            if let goToDatePickController = segue.destination as? DatePickViewController{
                
                
            }
            
        }
        
    }

}
