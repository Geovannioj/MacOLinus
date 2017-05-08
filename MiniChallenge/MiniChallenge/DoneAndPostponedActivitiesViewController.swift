//
//  DoneAndPostponedActivitiesViewController.swift
//  MiniChallenge
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 06/05/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class DoneAndPostponedActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let redColor = UIColor(colorLiteralRed: 0.9804, green: 0.4588, blue: 0.4431, alpha: 1)
    
    struct activity{
        var activity :String
        var subject: String
        var color:UIColor
        var image:UIImage
        var time:String
    }
    
    var doneActivity: [activity] = []
    var postponedActivity: [activity] = []
    
    func initialize() {
        doneActivity.append(activity(activity: "Fazer Fichamento", subject: "Economia", color: UIColor.blue, image: UIImage(named: "check.png")!, time: "Feito em: 14/04/2017"))
        doneActivity.append(activity(activity: "Estudar", subject: "Desenho", color: UIColor.green, image: UIImage(named: "check.png")!, time: "Feito em: 20/05/2017"))
        postponedActivity.append(activity(activity: "Fazer relatorio", subject: "IHC", color: UIColor.brown, image: UIImage(named: "clock.png")!, time: "30/06/2017 - 18:00"))
    }
    

    @IBOutlet weak var activitiesSegment: UISegmentedControl!
    @IBOutlet weak var activitiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        activitiesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        switch activitiesSegment.selectedSegmentIndex {
        case 0:
            returnValue = doneActivity.count
            break
        default:
            returnValue = postponedActivity.count
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DoneAndPostponedActivitiesTableViewCell", owner: self, options: nil)?.first as! DoneAndPostponedActivitiesTableViewCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = redColor.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        //delay button
        let delayButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "delay.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Cliquei em Delay")
            return true
        }
        
        //edit button
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Cliquei em Edit")
            return true
        }
        
        //done button
        let doneButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "done.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Cliquei em Done")
            
            //stobyboard reference
            let newStoryBoard = UIStoryboard(name: "Calendar", bundle: nil)
            let newViewController = newStoryBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
            newViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            
            self.present(newViewController, animated: true, completion: nil)
            
            
            return true
        }
        
        //undo button
        let undoButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "undo.png")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Cliquei em Undo")
            return true
        }

        
        switch activitiesSegment.selectedSegmentIndex {
        case 0:
            cell.activityLabel.text = doneActivity[indexPath.row].activity
            cell.colorLabel.backgroundColor = doneActivity[indexPath.row].color
            cell.iconImage.image = doneActivity[indexPath.row].image
            cell.timeLabel.text = doneActivity[indexPath.row].time
            cell.subjectLabel.text = doneActivity[indexPath.row].subject
            cell.rightButtons = [undoButton, editButton]
            cell.rightSwipeSettings.transition = .border
            break
        default:
            cell.activityLabel.text = postponedActivity[indexPath.row].activity
            cell.colorLabel.backgroundColor = postponedActivity[indexPath.row].color
            cell.iconImage.image = postponedActivity[indexPath.row].image
            cell.timeLabel.text = postponedActivity[indexPath.row].time
            cell.subjectLabel.text = postponedActivity[indexPath.row].subject
            cell.leftButtons = [delayButton, editButton]
            cell.leftSwipeSettings.transition = .border
            cell.rightButtons = [doneButton]
            cell.rightSwipeSettings.transition = .border
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
