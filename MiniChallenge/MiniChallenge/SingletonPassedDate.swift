//
//  SingletonPassedDate.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 15/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

struct PassedDate {
    var passedDate:Date?
}

class SingletonPassedDate {
    var passedDate: Date
    
    static let sharedInstance = SingletonPassedDate()
    
    private init() {
        self.passedDate = Date()
    }
    
    func setPassedDate(newPassedDate:Date) {
        self.passedDate = newPassedDate
    }
}
