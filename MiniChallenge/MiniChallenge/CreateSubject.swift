//
//  CreateSubject.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 20/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateSubject: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var addressField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var submittedASubject: UIButton!

    @IBAction func submitted(_ sender: Any) {
    
    
    }
}
