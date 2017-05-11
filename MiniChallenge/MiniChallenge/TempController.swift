//
//  TempController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 09/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class TempController: UIViewController {

    var data: String = "Nada"
    var segueData: String?
    
    @IBOutlet weak var nextScreenBtn: UIButton!
    @IBOutlet weak var subjectCreatedLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    // MARK - Config
    
    func setConfig() {
        
        assignBlackStatusBar()
        assignBackground()
        
        subjectCreatedLabel.text = data
        
    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
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
    
    @IBAction func nextScreen(_ sender: Any) {
        
        if segueData == "GoToAddSubject"{
           performSegue(withIdentifier: "GoToSubjectChoice", sender: Any?.self)
        }else{
            performSegue(withIdentifier: "GoToHomeSubject", sender: Any?.self)
        }
        
        
        
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
