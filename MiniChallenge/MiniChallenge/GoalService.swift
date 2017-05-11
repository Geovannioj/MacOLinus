//
//  GoalService.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 11/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class GoalService {

    
    var user_goals  = [Goal]()
    var user_goal = Goal()
    
    static let sharedInstance = GoalService()
    
    private init() {

    }
}
