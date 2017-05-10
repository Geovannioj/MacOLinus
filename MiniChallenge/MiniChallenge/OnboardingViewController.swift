//
//  OnboardingViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 29/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


//    import UIKit
//    import paper_onboarding
//    
//    
//    class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
//        
//        @IBOutlet weak var onboardingView: OnBoardingView!
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Do any additional setup after loading the view, typically from a nib.
//            onboardingView.dataSource = self
//            onboardingView.delegate = self
//            
//            
//        }
//        
//        
//        func onboardingItemsCount() -> Int {
//            let onboardingPages = 4
//            
//            return onboardingPages
//            
//        }
//        
//        
//        func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
//            
//            let backgroundColorOne = UIColor(red: 0.2902, green: 0.3765, blue: 0.8588, alpha: 1)
//            let backgroundColorTwo = UIColor(red: 0.9804, green: 0.8196, blue: 0.1882, alpha: 1)
//            let backgroundColorThree = UIColor(red: 0.2784, green: 0.9020, blue: 0.7686, alpha: 1)
//            let backgroundColorFour = UIColor(red: 0.9725, green: 0.4627, blue: 0.4549, alpha: 1)
//            
//            
//            let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
//            let textFont = UIFont(name: "AvenirNext-Regular", size: 18)!
//            
//            
//            var onboardingPages = [OnboardingItemInfo]()
//            
//            
//            let firstPage = OnboardingItemInfo("Pengo", "Calendar is amazing", "hwduiweduwhiuhdueiwhduedewdeedwebd", "", backgroundColorOne, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            let secondPage = OnboardingItemInfo("Pengo", "Calendar is amazing", "hwduiweduwhiuhdueiwhduedewdeedwebd", "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            let thirdPage = OnboardingItemInfo("Pengo", "Calendar is amazing", "hwduiweduwhiuhdueiwhduedewdeedwebd", "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            
//            let fourthPage = OnboardingItemInfo("Pengo", "Calendar is amazing", "hwduiweduwhiuhdueiwhduedewdeedwebd", "", backgroundColorFour, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            onboardingPages.append(firstPage)
//            onboardingPages.append(secondPage)
//            onboardingPages.append(thirdPage)
//            onboardingPages.append(fourthPage)
//            
//            return onboardingPages[index]
//            
//        }
//        
//        
//        
//        func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
//            
//            
//            
//        }
//        
//        func onboardingWillTransitonToIndex(_ index: Int) {
//            //
//            //        if index  == 1 {
//            //            if self.getStartedButton.alpha == 1 {
//            //                UIView.animate(withDuration: 0.2, animations: {
//            //                  self.getStartedButton.alpha = 0
//            //                })
//            //            }
//            //        }
//            
//            
//        }
//        
//        func onboardingDidTransitonToIndex(_ index: Int) {
//            
//            // It has to create a button to execute
//            
//            //        if index == 2  {
//            //            UIView.animate(withDuration: 0.4, animations: {
//            //                self.getStartedButton.alpha = 1 })
//            //        }
//        }
//        
//        override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//            // Dispose of any resources that can be recreated.
//        }
//        
//        
//    }
    
    
//    
//    import UIKit
//    import paper_onboarding
//    
//    
//    class ViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
//        
//        @IBOutlet weak var onboardingView: OnBoardingView!
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            
//            // Do any additional setup after loading the view, typically from a nib.
//            onboardingView.dataSource = self
//            onboardingView.delegate = self
//            
//            
//        }
//        
//        
//        func onboardingItemsCount() -> Int {
//            let onboardingPages = 4
//            
//            return onboardingPages
//            
//        }
//        
//        
//        func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
//            
//            
//            var onboardingPages = [OnboardingItemInfo]()
//            
//            let customPurple = UIColor(red: 0.2902, green: 0.3765, blue: 0.8588, alpha: 1)
//            let customYellow = UIColor(red: 0.9804, green: 0.8196, blue: 0.1882, alpha: 1)
//            let customGreen = UIColor(red: 0.2784, green: 0.9020, blue: 0.7686, alpha: 1)
//            let customRed = UIColor(red: 0.9725, green: 0.4627, blue: 0.4549, alpha: 1)
//            
//            
//            let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
//            let textFont = UIFont(name: "AvenirNext-Regular", size: 18)!
//            
//            
//            
//            let firstPage = OnboardingItemInfo("Onboard 1", "", "O pengo app foi feito especialmente para estudantes se organizarem de forma simples e intuitiva", "", customYellow, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            let secondPage = OnboardingItemInfo("Bitmap", "", "Todas sua tarefas organizadas de forma simples.", "", customRed, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            let thirdPage = OnboardingItemInfo("Bitmap1", "", "Defina metas e conquiste seus objetivos!", "", customPurple, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            
//            let fourthPage = OnboardingItemInfo("Bitmap2", "", "Organize suas atividades de acordo com as matérias do seu curso.", "", customGreen, UIColor.white, UIColor.white, titleFont, textFont)
//            
//            onboardingPages.append(firstPage)
//            onboardingPages.append(secondPage)
//            onboardingPages.append(thirdPage)
//            onboardingPages.append(fourthPage)
//            
//            return onboardingPages[index]
//            
//        }
//        
//        
//        
//        func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
//            
//            
//            
//        }
//        
//        func onboardingWillTransitonToIndex(_ index: Int) {
//            
//            
//        }
//        
//        func onboardingDidTransitonToIndex(_ index: Int) {
//            
//        }
//        
//        override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//            // Dispose of any resources that can be recreated.
//        }
//        
//        
//    }




}
