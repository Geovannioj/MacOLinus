//
//  GoalService.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import CoreLocation

class GoalService {

    var user_goals  = [Goal]()
    var user_goal = Goal()
    var doneUserGoals = [Goal]()
    var index: Int = -1
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    static let sharedInstance = GoalService()
    
    private init() {

    }
}
