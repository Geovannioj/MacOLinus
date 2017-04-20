//
//  ReminderViewController.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController {

    var isGrantedNotificationAccess:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //checking for permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            self.isGrantedNotificationAccess = granted
            })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send10SecNotification(_ sender: UIButton) {
        if isGrantedNotificationAccess{
            //add notification code
            let content = UNMutableNotificationContent()
            content.title = "10 Second Notification Demo"
            content.subtitle = "From MakeApppie.com"
            content.body = "Notification after 10 seconds - Your pizza"
            content.categoryIdentifier = "Message"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            let request = UNNotificationRequest(identifier: "10.second.message", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
