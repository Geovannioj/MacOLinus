//
//  SelectSubjectColorViewController.swift
//  MiniChallenge
//
//  Created by Miguel Pimentel on 23/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class SelectSubjectColorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var colors = [UIColor]()
    var aColorWasSelected = false
    @IBOutlet weak var validation: UILabel!
    
    let customRed = UIColor(colorLiteralRed: 1.0000, green: 0.3412, blue: 0.4392, alpha: 1.0)
    let customYellow = UIColor(colorLiteralRed: 1.0000, green: 0.8275, blue: 0.4392, alpha: 1.0)
    let customOrange = UIColor(colorLiteralRed: 1.0000, green: 0.4471, blue: 0.3804, alpha: 1.0)
    let customGreen = UIColor(colorLiteralRed: 0.6275, green: 0.8549, blue: 0.4980, alpha: 1.0)
    let customBlueGreened = UIColor(colorLiteralRed: 0.0000, green: 0.8431, blue: 0.7255, alpha: 1.0)
    let customLightBlue = UIColor(colorLiteralRed: 0.0471, green: 0.7922, blue: 0.9098, alpha: 1.0)
    let customBlue = UIColor(colorLiteralRed: 0.3216, green: 0.6549, blue: 0.9137, alpha: 1.0)
    let customPurple = UIColor(colorLiteralRed: 0.7216, green: 0.6157, blue: 0.9176, alpha: 1.0)
    let customPink = UIColor(colorLiteralRed: 0.9843, green: 0.5647, blue: 0.7686, alpha: 1.0)
    let customGray = UIColor(colorLiteralRed: 0.6941, green: 0.7333, blue: 0.7686, alpha: 1.0)
    let customBlack = UIColor(colorLiteralRed: 0.2902, green: 0.3294, blue: 0.3686, alpha: 1.0)
    let customViolet = UIColor(colorLiteralRed: 0.7804, green: 0.2549, blue: 0.4863, alpha: 1.0)
    
    var segueData:String?
    var auxSegue:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validation.isHidden = true
        
        configLayout()
        
        colors = [  customRed,
                    customYellow,
                    customOrange,
                    customGreen,
                    customBlueGreened,
                    customLightBlue,
                    customBlue,
                    customPurple,
                    customPink,
                    customGray,
                    customBlack,
                    customViolet ]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configLayout() {
        
        assignBackground()
        assignBlackStatusBar()
        
    }
    
    func assignBackground() {
        
        let background = UIImage(named: "greenPatternWithBoy")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorsCollectionViewCell
        
        cell.layer.cornerRadius = 25
        cell.backgroundColor = colors[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        aColorWasSelected = true
        let cell = collectionView.cellForItem(at: indexPath) as! ColorsCollectionViewCell
        
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        
        SingletonSubject.sharedInstance.subject.color = colors[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColorsCollectionViewCell
        
        cell.layer.borderWidth = 0
    }

    
    // MARK: - Persist Data
    
    func saveSubjects() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(SingletonSubject.sharedInstance.subjects, forKey: "Subjects")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
        
    }
    
    func loadSubjects() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            SingletonSubject.sharedInstance.subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Subjects.plist")
        
    }
    
    // MARK: - Navigation
    
    @IBAction func nextScreenPressed(_ sender: Any) {
        
        if aColorWasSelected{
            createSubject()
            saveSubjects()
            performSegue(withIdentifier: "SubjectCreated", sender: Any?.self)
        }else{
            validation.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier ==  "SubjectCreated"{
            if let nextScreen = segue.destination as? SubjectCreated {
                nextScreen.segueData = segueData
            }
        }
    }
    func createSubject() {
        
        let newSubject = SingletonSubject.sharedInstance.subject
        SingletonSubject.sharedInstance.subjects.append(newSubject)
    }
    
    

    
    
}
