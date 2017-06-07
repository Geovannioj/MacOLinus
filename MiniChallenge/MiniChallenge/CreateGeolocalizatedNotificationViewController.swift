//
//  CreateGeolocalizatedNotificationViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 31/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class CreateGeolocalizatedNotificationViewController: UIViewController, CLLocationManagerDelegate {
    
    
    let locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude = GoalService.sharedInstance.coordinate.latitude
        let longitude = GoalService.sharedInstance.coordinate.longitude
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
        
        let currentRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: 200, identifier: "Home")
        locationManager.startMonitoring(for: currentRegion)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

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
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()    
    }
    
    func saveUserGoals() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(GoalService.sharedInstance.user_goals, forKey: "UserGoals")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        let newUserGoal = GoalService.sharedInstance.user_goal
        GoalService.sharedInstance.user_goals.append(newUserGoal)
        
        saveUserGoals()
        
        
        performSegue(withIdentifier: "HomeGoal", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeGoal"{
            CalendarViewController.pushedFromHomeGoal = true
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
    }
    
//    func asnas(id: Int, completion: (()->())?) {
//        completion?()
////        completilocationManager(<#T##manager: CLLocationManager##CLLocationManager#>, didExitRegion: <#T##CLRegion#>){}
//    }
//    
//    func a() {
//        asnas(id: 1, completion: {
//            print("aaaa")
//            
//            //completilocationManager(<#T##manager: CLLocationManager##CLLocationManager#>, didExitRegion: <#T##CLRegion#>){}
//
//        
//        
//        })
//        
//    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    internal func assignBackground() {
        
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
    
    // MARK - Notification
    @IBAction func NextScreenPressed(_ sender: Any) {
    
        
    
    }
    
    func geolocalizatedNotification() {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "fvaefv"
        content.body = "vafadvavadvfdavadv"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        NSLog("ENTROU NA UNIVERSIDADE")
        geolocalizatedNotification()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        NSLog("SAIU DA UNIVERSIDADE")
        geolocalizatedNotification()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("\(error)")
    }
    
    
    // MARK: - Persist Data
    
    func saveUserGoals() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(GoalService.sharedInstance.user_goals, forKey: "UserGoals")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadUserGoals() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            GoalService.sharedInstance.user_goals = unarchiver.decodeObject(forKey: "UserGoals") as! [Goal]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
    }
    


}
