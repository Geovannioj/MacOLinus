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
    
    var subjectsActivity: [Reminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
}
