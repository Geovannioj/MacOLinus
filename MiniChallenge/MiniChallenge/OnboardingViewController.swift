//
//  OnboardingViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 29/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate, UIGestureRecognizerDelegate{
    
    var window: UIWindow?
    @IBOutlet weak var skipLabel: UILabel!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var onboarding: UIView!
    
    @IBAction func goToCalendar(_ sender: Any) {
        performSegue(withIdentifier: "GoToCalendar", sender: Any?.self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        item.superview?.superview?.addSubview(skipLabel)
        item.superview?.superview?.addSubview(skipButton)
        item.superview?.superview?.bringSubview(toFront: skipButton)

        if index == 0{
            skipLabel.isHidden = true
            skipButton.isHidden = true
        }else if index == 1{
            skipLabel.isHidden = false
            skipButton.isHidden = false
            skipLabel.textColor = UIColor.white
            skipLabel.text = "Pular"
            skipButton.backgroundColor = UIColor(patternImage: UIImage(named: "skipButton1")!)
        }else if index == 2{
            skipLabel.textColor = UIColor.white
            skipLabel.text = "Pular"
            skipButton.backgroundColor = UIColor(patternImage: UIImage(named: "skipButton2")!)
        }else{
            skipLabel.text = "Começar"
            skipLabel.textColor = UIColor.black
            skipButton.backgroundColor = UIColor(patternImage: UIImage(named: "skipButton3")!)
        }
    }

    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        
        let backgroundColorOne = UIColor(patternImage: UIImage(named: "OnboardingBackground1")!)
        let backgroundColorTwo = UIColor(patternImage: UIImage(named: "Pink Pattern")!)
        let backgroundColorThree = UIColor(patternImage: UIImage(named: "purplePattern")!)
        let backgroundColorFour = UIColor(patternImage: UIImage(named: "greenPattern")!)
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let textFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        var onboardingPages = [OnboardingItemInfo]()
        
        let firstPage = OnboardingItemInfo("pengoOnboarding1", "", "O Pengo app foi feito especialmente para estudantes se organizarem de forma simples e intuitiva", "", backgroundColorOne, UIColor.white, UIColor.black, titleFont, textFont)
        
        let secondPage = OnboardingItemInfo("onboarding2", "", "Todas suas tarefas organizadas de forma simples", "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, textFont)
        
        let thirdPage = OnboardingItemInfo("onboarding3", "", "Defina metas e conquiste seus objetivos!", "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, textFont)
        
        let fourthPage = OnboardingItemInfo("onboarding4", "", "Organize suas atividades de acordo com as matérias do seu curso", "", backgroundColorFour, UIColor.white, UIColor.black, titleFont, textFont)
        
        onboardingPages.append(firstPage)
        onboardingPages.append(secondPage)
        onboardingPages.append(thirdPage)
        onboardingPages.append(fourthPage)
        
        return onboardingPages[index]

    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        skipButton.touchesBegan(touches, with: event)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton{
            goToCalendar(self)
        }
        return true
    }
    
}

