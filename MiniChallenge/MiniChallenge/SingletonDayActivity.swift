//
//  SingletonDayActivity.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 04/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

struct dayActivities {
    
    var activityName = ""
    var activityColor = UIColor()
    var activitySubject = ""
    var activityTime = ""
}

class SingletonDayActivity {
    
    var activities: [dayActivities] = []
    
    static let sharedInstance = SingletonDayActivity()
    
    private init() {
        
    }
    
    func addActivity(activityName:String, activityColor:UIColor, activitySubject:String, activityTime:String) {
        
        let activity = dayActivities(activityName: activityName, activityColor: activityColor, activitySubject: activitySubject, activityTime: activityTime)
        activities.append(activity)
    }
}
