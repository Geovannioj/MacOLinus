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

    @IBOutlet weak var userGoalTitleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {
            didAllow, error in
            
        })
        
        
        setConfig()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    func assignBackground() {
        
        let background = UIImage(named: "PurplePatternWithBoy")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func setDatePickerColor() {
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        setDatePickerColor()
    
        userGoalTitleLabel.text = GoalService.sharedInstance.user_goal.title
    }
    
    
   
    @IBAction func submitnewUserGoal(_ sender: Any) {
        
        let date = datePicker.date
        scheduleNotification(at: date)
     }
    
    //MARK: - Notification
    
    func scheduleNotification(at date: Date) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
    
        let content = UNMutableNotificationContent()
        content.title = "Pengo"
        content.body = "Pengo is notifying you"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)

//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
    }
   
}
