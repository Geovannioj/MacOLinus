//
//  CreateSubject.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 08/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateSubject: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var subjectField: UITextField!
    
    @IBAction func newSubjectRequested(_ sender: Any) {
        
        let data = PersistSubjectData()
        
        if subjectField.text != "" {
            
            SingletonSubject.subjectSharedInstance.subject.title = subjectField.text!
        }
        
        SingletonSubject.subjectSharedInstance.subject.color = assignSubjectColor()
        
        let newSubject = SingletonSubject.subjectSharedInstance.subject
        
        SingletonSubject.subjectSharedInstance.subjects.append(newSubject)
        
        data.saveSubjects()
        
        print(subjectField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configLayout()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createSubject(_ sender: Any) {
    
        let data = PersistSubjectData()
        
        if subjectField.text != "" {
            
            SingletonSubject.subjectSharedInstance.subject.title = subjectField.text!
        }
        
        SingletonSubject.subjectSharedInstance.subject.color = assignSubjectColor()
        
        let newSubject = SingletonSubject.subjectSharedInstance.subject
    
        SingletonSubject.subjectSharedInstance.subjects.append(newSubject)
        
        data.saveSubjects()
        
        print(subjectField.text!)
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
    
    
    internal func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
    }
    
    internal func assignBackground() {
        
        let background = UIImage(named: "greenPatternWithBoy")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    internal func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }

    
}
