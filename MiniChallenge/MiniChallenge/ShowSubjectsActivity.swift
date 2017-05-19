//
//  ShowSubjectsActivity.swift
//  MiniChallenge
//
//  Created by Geovanni Oliveira de Jesus on 18/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class ShowSubjectsActivity: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var subjectsActivityTableView: UITableView!
    @IBOutlet weak var subjectNameLbl: UILabel!
    @IBOutlet weak var subjectColorLBl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var subjectReceived:Subject?
    var subjectsActivity: [Reminder] = []
    var receivedArray: [Reminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectsActivity = receivedArray
        
        subjectNameLbl.text = subjectReceived?.title
        subjectColorLBl.backgroundColor = subjectReceived?.color
        
        subjectsActivityTableView.delegate = self
        subjectsActivityTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath)
//        let activity = subjectsActivity[indexPath.row]
//        
//        let activityName = cell?.viewWithTag()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsActivity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activities", for: indexPath)
        let activity = subjectsActivity[indexPath.row]
        
        let activityNameLabel = cell.viewWithTag(30) as! UILabel
        let activityTimeLabel = cell.viewWithTag(31) as! UILabel
        
        activityNameLabel.text = activity.title
        activityTimeLabel.text = String(describing: activity.time)
        
        return cell

    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        performSegue(withIdentifier: "BackToSubjectsHome", sender: Any?.self)
        
    }
}
