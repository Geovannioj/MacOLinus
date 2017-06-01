//
//  CreateNoteTitleViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateNoteTitleViewController: UIViewController {

    @IBOutlet weak var noteTitleField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    @IBAction func nextScreenPressed(_ sender: Any) {
        
        addNoteTitleToSubject()
        performSegue(withIdentifier: "CreateNoteContent", sender: Any?.self)
    }
    
    // MARK: - Setting Content
    
    func addNoteTitleToSubject() {
        
        NoteService.sharedInstance.note.title = noteTitleField.text!
        
    }
    
    // MARK: - Layout Config
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
    }
    
    func assignBackground() {
        
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
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
}
