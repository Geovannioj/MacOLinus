//
//  CreateSubject.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 08/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateSubject: UIViewController {
    
    @IBOutlet weak var subjectField: UITextField!
    
    var segueData:String?
    var auxSegue:String?
    var passedTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: HomeSubject.pengoBlackImage)
        if segueData != "EditSubjectTitle"{
            self.cleanBuffer()
        }
        configLayout()
        validation.isHidden = true

        SingletonSubject.sharedInstance.subject.faults = 0
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        
        if segueData == "EditSubjectTitle"{
            let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = backButton
            subjectField.text = passedTitle
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helpers
    
    internal func cleanBuffer () {
    
        SingletonSubject.sharedInstance.subject = Subject()
    }
    
    
    @IBOutlet weak var validation: UILabel!
    
    
    @IBAction func newSubjectRequired(_ sender: Any) {
        
        if subjectField.text != ""{
            if segueData == "EditSubjectTitle" {
                SingletonSubject.sharedInstance.subject.title = subjectField.text!
                _ = navigationController?.popViewController(animated: true)
            }else{
                SingletonSubject.sharedInstance.subject.title = subjectField.text!
                SingletonSubject.sharedInstance.subject.color = assignSubjectColor()
                performSegue(withIdentifier: "CreateTeacher", sender: Any?.self)
            }
            
        }else{
            validation.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CreateTeacher" {
            
            if let toNextScreen = segue.destination as? CreateTeacherViewController {
                toNextScreen.segueData = segueData
            }
        }else if segue.identifier == "HomeSubject"{
            CalendarViewController.pushedFromHomeSubject = true
        
        }else if segue.identifier == "BackToSubjectChoice" {
            if let backToScreen = segue.destination as? ChooseSubjectController {
                backToScreen.segueRecived = self.segueData!
            }
        }
    }
    
    
    func assignSubjectColor() -> UIColor {
        
        let customRed = UIColor(colorLiteralRed: 1.0000, green: 0.3412, blue: 0.4392, alpha: 1.0)
        let customYellow = UIColor(colorLiteralRed: 1.0000, green: 0.8275, blue: 0.4392, alpha: 1.0)
        let customOrange = UIColor(colorLiteralRed: 1.0000, green: 0.4471, blue: 0.3804, alpha: 1.0)
        let customGreen = UIColor(colorLiteralRed: 0.6275, green: 0.8549, blue: 0.4980, alpha: 1.0)
        let customBlueGreened = UIColor(colorLiteralRed: 0.0000, green: 0.8431, blue: 0.7255, alpha: 1.0)
        let customLightBlue = UIColor(colorLiteralRed: 0.0471, green: 0.7922, blue: 0.9098, alpha: 1.0)
        let customBlue = UIColor(colorLiteralRed: 0.3216, green: 0.6549, blue: 0.9137, alpha: 1.0)
        let customPurple = UIColor(colorLiteralRed: 0.7216, green: 0.6157, blue: 0.9176, alpha: 1.0)
        let customPink = UIColor(colorLiteralRed: 0.9843, green: 0.5647, blue: 0.7686, alpha: 1.0)
        let customGray = UIColor(colorLiteralRed: 0.6941, green: 0.7333, blue: 0.7686, alpha: 1.0)
        let customBlack = UIColor(colorLiteralRed: 0.2902, green: 0.3294, blue: 0.3686, alpha: 1.0)
        let customViolet = UIColor(colorLiteralRed: 0.7804, green: 0.2549, blue: 0.4863, alpha: 1.0)
        
        let subjectColor = [    customRed,
                                customYellow,
                                customOrange,
                                customGreen,
                                customBlueGreened,
                                customLightBlue,
                                customBlue,
                                customPurple,
                                customPink,
                                customGray,
                                customBlack,
                                customViolet ]
        
        let randomNumber = Int(arc4random_uniform(11))
        
        return subjectColor[randomNumber]
    }

    // MARK: - Config Layout
    
    
   func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        hideKeyboardWhenTappedAround()
        
    }
    
    func assignBackground() {
        
        let background = UIImage(named: "greenPatternWithBoy")
        self.view.backgroundColor = UIColor(patternImage: background!)
    }
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default

    }
    
    
    // MARK: - Persist Data
    
    
    func saveSubjects() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(SingletonSubject.sharedInstance.subjects, forKey: "Subjects")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
        
    }
    
    func loadSubjects() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonSubject.sharedInstance.subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Subjects.plist")
        
    }

    
}
