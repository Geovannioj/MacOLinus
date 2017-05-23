//
//  SelectWhereToNotifyViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 18/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications


class SelectWhereToNotifyViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    var coordinateToNotify: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        
    
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
    

    
    // MARK: - General Setup
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        setupMap()
    }
    
    
    // MARK: - Layout Setup
    
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
    
    
     // MARK: - Map Setup
    
    func setupMap() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]

        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latitudeDelta: CLLocationDegrees = 0.05
        let longitudeDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.map.setRegion(region, animated: true)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(SelectWhereToNotifyViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 1.5
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        
        coordinateToNotify = coordinate
        
        annotation.coordinate = coordinate
        
        annotation.title = "New place"
        annotation.subtitle = "Just a description"
        
        map.addAnnotation(annotation)
        
    }

    // MARK: - Navigation
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        geolocalizatedNotification()
        
        performSegue(withIdentifier: "SelectDate", sender: Any?.self)
    }
    
    // MARK - Notification
    
    func geolocalizatedNotification() {
        
        let latitude = coordinateToNotify.latitude
        let longitude = coordinateToNotify.longitude
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Geolocalizated Notification")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
    
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

    

}
