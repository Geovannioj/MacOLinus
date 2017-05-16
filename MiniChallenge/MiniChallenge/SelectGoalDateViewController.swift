//
//  SelectDateViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 15/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class SelectGoalDateViewController: UIViewController {

    
    @IBOutlet weak var mondayCheckbox: UIButton!
    
    var Checked = UIImage(named: "checkboxSelected")
    var Unchecked = UIImage(named: "checkbokEmpty")
    
    var isMondaySelected: Bool = false
    var isTuesaySelected: Bool = false
    var isWednesdaySelected: Bool = false
    var isThursdaySelected: Bool = false
    var isFridaySelected: Bool = false
    var isSaturdarSelected: Bool = false
    var isSundaySelected: Bool = false
    
    
    // MARK: - Checkboxes
    
    @IBAction func mondaySelected(_ sender: Any) {
    
        if isMondaySelected {
            isMondaySelected = false
        } else {
            isMondaySelected = true
        }
        
        if isMondaySelected {
            mondayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            mondayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        setConfig()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
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
    
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        
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
