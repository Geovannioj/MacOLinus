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
    
    var cellText = ["Tarefa", "Matéria", "Horário"]
    static var activityPassed = Reminder()
    var activityToBeSaved = Reminder()
    var indexActivityToEdit: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Pink Pattern.pgn")!)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("index chegando na tela de edit")
        print(indexActivityToEdit)
        
        EditActivityController.activityPassed = SingletonActivity.sharedInstance.tasks[indexActivityToEdit]
        print("atividade do arraySingleton")
        print(SingletonActivity.sharedInstance.tasks[indexActivityToEdit].title)

    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        let controlerPList = ControllerPList()
        
        SingletonActivity.sharedInstance.tasks[indexActivityToEdit] = EditActivityController.activityPassed
        
        print("Atividade")
        print(EditActivityController.activityPassed.title)
        
        controlerPList.saveReminders()
        
        performSegue(withIdentifier: "GoToCalendar", sender: Any?.self)
        
        EditActivityController.activityPassed = Reminder()
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
        
        if indexPath.row == 0 {
            recivedData.text = EditActivityController.activityPassed.title
            
        }else if indexPath.row == 1 {
            recivedData.text = EditActivityController.activityPassed.subject?.title
        }else if indexPath.row == 2 {
            recivedData.text = String(describing: EditActivityController.activityPassed.time)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            
            self.performSegue(withIdentifier: "Reminders", sender: tableView)
        
        }else if indexPath.row == 1{
            
            performSegue(withIdentifier: "ChooseSubjectController", sender: Any?.self)
        
        }else if indexPath.row == 2{
            
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
    
                goToChooseSubject.segueRecived = segue.identifier!
                goToChooseSubject.indexActivity = indexActivityToEdit
            }
        
        }else if segue.identifier == "Reminders" {
            
            if let goToReminderAddTitle = segue.destination as? AddTitleController{
                
                goToReminderAddTitle.segueRecived = segue.identifier!
                goToReminderAddTitle.indexActivityArray = indexActivityToEdit
            }
            
        }else if segue.identifier == "DatePickViewController" {
            
            if let goToDatePickController = segue.destination as? DatePickViewController{
                goToDatePickController.indexActivityToEdit = indexActivityToEdit
                goToDatePickController.segueRecived = segue.identifier!
                
            }
            
        }else if segue.identifier == "BackToCalendar"{
            if let backToCalendar = segue.destination as? CalendarViewController{
                backToCalendar.indexActivity = indexActivityToEdit
            }
        }
    }

}
