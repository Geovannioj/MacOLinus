import Foundation
import UIKit

class Note: NSObject, NSCoding {
    
    var title: String = ""
    var noteDescription: String = ""
    var images: [UIImage] = []
    
    
    // Path to save the notes
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("subjects")

    
    
    init(title:String, description:String, images:UIImage) {
        
        self.title = title
        self.noteDescription = description
        self.images.append(images)
    }
    
    
    init(title: String, noteDescription: String) {
        self.title = title
        self.noteDescription = noteDescription
    }
    
    // Update methods
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
    
    // Methods to persist data
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.noteDescription = decoder.decodeObject(forKey: "noteDescription") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(noteDescription, forKey: "noteDescription")
    }
    
}
