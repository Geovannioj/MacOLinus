//
//  NoteCreatedViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 30/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class NoteCreatedViewController: UIViewController {

    @IBOutlet weak var noteTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Config Layout
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
        noteTitleLabel.text = NoteService.sharedInstance.note.title
        
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
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        cleanBuffer()
        performSegue(withIdentifier: "backToHomeNotes", sender: Any?.self)
    
    
    }
    
    func cleanBuffer() {
        
        NoteService.sharedInstance.note.noteDescription = ""
        NoteService.sharedInstance.note.title = ""
        NoteService.sharedInstance.notes = [Note]()
        NoteService.sharedInstance.index = -1
        
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
