//
//  SelectWhereToNotifyViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 18/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MapKit

class SelectWhereToNotifyViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        setupMap()
    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    
    func setupMap() {
        
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
    

    @IBAction func nextScreenPressed(_ sender: Any) {
          performSegue(withIdentifier: "SelectDate", sender: Any?.self)
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
