//
//  SingletonSubject.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 08/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class SingletonSubject  {
    
    var subjects = [Subject]()
    var subject = Subject()
    
    static let sharedInstance = SingletonSubject()
    
    private init() {
    }
    
    
}
