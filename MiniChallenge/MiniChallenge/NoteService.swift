//
//  NoteService.swift
//  Note
//
//  Created by Miguel Pimentel on 29/05/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import Foundation


class NoteService {
    
    var notes = [Note]()
    var note = Note()
    
    static let sharedInstance = NoteService()
    
    private init() {
        
    }
}
