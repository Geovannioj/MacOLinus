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
    @IBOutlet weak var tuesdayCheckbox: UIButton!
    @IBOutlet weak var wednesdayCheckbox: UIButton!
    @IBOutlet weak var thursdayCheckbox: UIButton!
    @IBOutlet weak var fridayCheckbox: UIButton!
    @IBOutlet weak var saturdayCheckbox: UIButton!
    @IBOutlet weak var sundayCheckbox: UIButton!
    
    var Checked = UIImage(named: "checkboxSelected")
    var Unchecked = UIImage(named: "checkbokEmpty")
    
    var isMondaySelected: Bool = false
    var isTuesaySelected: Bool = false
    var isWednesdaySelected: Bool = false
    var isThursdaySelected: Bool = false
    var isFridaySelected: Bool = false
    var isSaturdaySelected: Bool = false
    var isSundaySelected: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setConfig()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
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
    
    @IBAction func tuesdaySelected(_ sender: Any) {
        
        if isTuesaySelected {
            isTuesaySelected = false
        } else {
            isTuesaySelected = true
        }
        
        if isTuesaySelected {
            tuesdayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            tuesdayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }
    }
    
    @IBAction func wednesdaySelected(_ sender: Any) {
        
        
        if isWednesdaySelected {
            isWednesdaySelected = false
        } else {
            isWednesdaySelected = true
        }
        
        if isWednesdaySelected {
            wednesdayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            wednesdayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }

        
    }
    

    
    @IBAction func thursdaySelected(_ sender: Any) {
        
        if isThursdaySelected {
            isThursdaySelected = false
        } else {
            isThursdaySelected = true
        }
        
        if isThursdaySelected {
            thursdayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            thursdayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }

    }
    
    @IBAction func fridaySelected(_ sender: Any) {
        
        
        if isFridaySelected {
            isFridaySelected = false
        } else {
            isFridaySelected = true
        }
        
        if isFridaySelected {
            fridayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            fridayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }

    }
 
    @IBAction func saturdaySelected(_ sender: Any) {
        
        if isSaturdaySelected {
            isSaturdaySelected = false
        } else {
            isSaturdaySelected = true
        }
        
        if isSaturdaySelected {
            saturdayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            saturdayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }

    
    }
    
    
    @IBAction func sundaySelected(_ sender: Any) {
        
        if isSundaySelected {
            isSundaySelected = false
        } else {
            isSundaySelected = true
        }
        
        if isSundaySelected {
            sundayCheckbox.setImage(Checked, for: UIControlState.normal)
        } else {
            sundayCheckbox.setImage(Unchecked, for: UIControlState.normal)
        }

    }
    
    @IBAction func nextPagePressed(_ sender: Any) {
        
        performSegue(withIdentifier: "SelectGoalDatetime", sender: Any?.self)
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
