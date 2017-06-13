//
//  EditGoalTitleViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 25/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class EditGoalTitleViewController: UIViewController {

    @IBOutlet weak var newGoalTitle: UITextField!
    
    @IBOutlet weak var validationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationLbl.isHidden = true
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        hideKeyboardWhenTappedAround()
     
        
        newGoalTitle.text = GoalService.sharedInstance.user_goal.title
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
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "EditGoal", sender: Any?.self)
    }
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        
        if newGoalTitle.text != ""{
            setNewContent()
            performSegue(withIdentifier: "backToEditGoal", sender: Any?.self)
        }else{
            validationLbl.isHidden = false
        }
    }
    
    func setNewContent() {
        
        GoalService.sharedInstance.user_goal.title = newGoalTitle.text!
        
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
