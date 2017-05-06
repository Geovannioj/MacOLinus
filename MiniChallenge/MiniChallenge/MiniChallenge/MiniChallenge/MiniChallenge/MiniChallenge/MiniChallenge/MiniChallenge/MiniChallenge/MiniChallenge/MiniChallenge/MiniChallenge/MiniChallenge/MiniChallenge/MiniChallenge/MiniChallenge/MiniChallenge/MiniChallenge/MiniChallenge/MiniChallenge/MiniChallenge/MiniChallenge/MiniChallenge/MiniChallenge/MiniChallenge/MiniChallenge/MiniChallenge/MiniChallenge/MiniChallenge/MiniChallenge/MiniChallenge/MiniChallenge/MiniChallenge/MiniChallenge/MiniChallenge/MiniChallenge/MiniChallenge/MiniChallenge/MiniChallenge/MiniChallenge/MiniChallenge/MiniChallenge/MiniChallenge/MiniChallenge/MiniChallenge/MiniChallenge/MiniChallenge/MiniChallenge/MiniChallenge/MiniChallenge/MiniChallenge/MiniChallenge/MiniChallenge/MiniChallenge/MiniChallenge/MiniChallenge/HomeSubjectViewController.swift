//
//  HomeSubjectViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 27/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class HomeSubjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cards = ["Name", "dsds"]
    
    
    
    @IBOutlet weak var subjectsCards: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        
        
        // Do any additional setup after loading the view.
        
        if cards.count == 0 {
            subjectsCards.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    internal func setBackgroundColor() {
        
        let backgroungColor = UIColor(red: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1.0)
        self.view.backgroundColor = backgroungColor
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        let numberOfSubjects = cards.count
        return numberOfSubjects
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectCardTableViewCell
        
        cell.myLabel.text = cards[indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        let rotation = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = rotation
        UIView.animate(withDuration: 0.9){
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
            
        }
        
        
        cell.backgroundColor = UIColor.brown
    }
    
    
    
}


