//
//  CreateSubjectViewController.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 19/04/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class CreateSubjectViewController: UIViewController {

    @IBOutlet weak var NoteDescription: UITextField!
    @IBOutlet weak var NoteTitle: UITextField!
    @IBOutlet weak var TeacherEmailField: UITextField!
    @IBOutlet weak var TeacherNameField: UITextField!
    @IBOutlet weak var PlaceField: UITextField!
    @IBOutlet weak var TitleField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(documentsDirectory())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("SouEuMesmo.plist")
    }
    @IBAction func pressButton(_ sender: UIButton) {
        let note = Note(title: NoteTitle.description, description: NoteDescription.description, images: UIImage(named: "Imagem.jpeg")!)
        let teacher = Teacher(name: TeacherNameField.description, email: TeacherEmailField.description)
        let subject = Subject(title: TitleField.description, place: PlaceField.description, icon: UIImage(named: "Imagem.jpeg")!, schedule: Date(), color: UIColor.black, teacher: teacher, note: note)
        
        
        let items: NSArray = [subject, teacher, note]
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "subject")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)

    }
    
//    internal func saveSubject() {
//        
//        UserDefaults.standard().set(subject, forKey: "subject")
//        
//        
//        
//        
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
