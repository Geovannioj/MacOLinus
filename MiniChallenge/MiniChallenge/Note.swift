//
//  Note.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import UIKit

class Note: NSObject{
    
    var title: String = ""
    var noteDescription: String = ""
    var images: [UIImage] = []
    
    
    init(title:String, description:String, images:UIImage) {
        
        self.title = title
        self.noteDescription = description
        self.images.append(images)
    }
    
    
    override init() {
        
        self.title = String()
        self.noteDescription = String()
    }
    
    //update methods
    func updateTitle(newTitle: String) {
        
        self.title = newTitle
    }
    
    func updateDescription(newDescription: String) {
        self.noteDescription = newDescription
    }
    
    func updateImage(oldImage: UIImage, newImage: UIImage) {
        let indexOfOldImage = self.images.index(of: oldImage)
        self.images[indexOfOldImage!] = newImage
    }
//

}
