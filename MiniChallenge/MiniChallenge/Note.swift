//
//  Note.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class Note{
    var title: String
    var description: String
    var images: [UIImage] = []
    
    init(title:String, description:String, images:UIImage){
        self.title = title
        self.description = description
        self.images.append(images)
    }
}
