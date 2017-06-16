//
//  SelectGoalDateTime.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 12/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import UserNotifications


class SelectGoalDatetime: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {
            didAllow, error in
            
        })
        self.navigationItem.titleView = UIImageView(image: HomeGoal.pengoWhiteImage)
        
        setConfig()

        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "CreateGoal", sender: Any?.self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoalCreated"{
            CalendarViewController.pushedFromHomeGoal = true
        }
    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    func assignBackground() {
        
        self.textView.backgroundColor = UIColor.clear
        titleText.backgroundColor = UIColor(patternImage: UIImage(named: "PurplePatternWithBoy")!)
        let background = UIImage(named: "PurplePatternWithBoy")
        self.view.backgroundColor = UIColor(patternImage: background!)
        
    }
    
    func setDatePickerColor() {
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        setDatePickerColor()
    
        //userGoalTitleLabel.text = GoalService.sharedInstance.user_goal.title
    }
    
    
   
    @IBAction func submitnewUserGoal(_ sender: Any) {
        let date = datePicker.date
        GoalService.sharedInstance.user_goals.append(GoalService.sharedInstance.user_goal)
        saveUserGoals()
        scheduleNotification(at: date)
        performSegue(withIdentifier: "GoalCreated", sender: Any?.self)
    
    }
    
    //MARK: - Notification
    
    func scheduleNotification(at date: Date) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        
        
//        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)

        let newComponents = DateComponents(calendar: calendar, timeZone: .current, hour: components.hour, minute: components.minute)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: true)
        
    
        let content = UNMutableNotificationContent()
        content.title = "Você tem uma meta para cumprir"
        content.body =  "Hora de " + GoalService.sharedInstance.user_goal.title
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: GoalService.sharedInstance.user_goal.title, content: content, trigger: trigger)

//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
    }
    
    func saveUserGoals() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(GoalService.sharedInstance.user_goals, forKey: "UserGoals")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
        
    }

   
}
