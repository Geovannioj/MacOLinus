import UIKit
import MGSwipeTableCell

class SubjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var subjects = [Subject]()
    let subjectTitleLabel = ""
    var segueData:String?
    var auxSegue:String?
    
    var filteredActivityArray = [Reminder]()
    var subjectInRow: Subject?
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfig()
        
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        self.tabBarItem.image = UIImage(named: "subject line")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: "Subjects Fill")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.brown], for: .selected)
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.brown], for: UIControlState())
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - Config
    
    func setConfig() {
        
        loadSubjects()
        
        
        assignBlackStatusBar()
        assignBackground()

    }
    
    
    func assignBlackStatusBar() {
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    internal func assignBackground() {
        
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
    
    

    
    // MARK: - Actions

 
    @IBAction func newSubjectRequested(_ sender: Any) {
    
        let newSubject = Subject()
        
        if subjectTextField.text != "" {
            
            newSubject.title = subjectTextField.text!
            newSubject.color = assignSubjectColor()
            subjects.append(newSubject)
            
            
            saveSubjects()
        }
        
    }
    
    @IBAction func backToPreviousScreen(_ sender: Any){
        if (segueData == "GoToAddSubject" || segueData == "AddActivity" || segueData == "AddActivityByDone" || segueData == "AddActivityByDaily" || segueData == "ChooseSubjectController"){
            
            performSegue(withIdentifier: "BackToSubjectChoice", sender: Any?.self)
            
        }else{
            performSegue(withIdentifier: "BackToHomeSubject", sender: Any?.self)
        }
    }
    
    // MARK: - Presents subjects
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let customRowSize: CGFloat = 78.0
        
        return customRowSize
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return subjects.count
    }
    
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
//        
//        saveSubjects()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let subjectInRow = subjects[indexPath.row]
        
        filterSubjectsActivity(subjectName: subjectInRow.title)
        self.subjectInRow = subjectInRow
        performSegue(withIdentifier: "ShowASubject", sender: Any?.self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubjectTableViewCell
        
        cell.subjectTitleLabel.text = subjects[indexPath.row].title
        cell.subjectColorLabel.backgroundColor = subjects[indexPath.row].color
       
        
        let deleteButton = MGSwipeButton(title: "          ", backgroundColor: UIColor(patternImage: UIImage(named: "delete")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            let controllerReference = ControllerPList()
            var position = 0
            
            for activity in SingletonActivity.sharedInstance.tasks {
                print("Total: \(SingletonActivity.sharedInstance.tasks.count)")
                print("On position:\(position)")
                if activity.title == self.subjects[indexPath.row].title {
                    print("Removed at:\(position)")
                    SingletonActivity.sharedInstance.tasks.remove(at: position)
                    controllerReference.saveReminders()
                }
                position += 1
            }
            
            self.subjects.remove(at: indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
            
            self.saveSubjects()
            self.loadSubjects()
            
            return true
        }
        
       
        let editButton = MGSwipeButton(title: "            ", backgroundColor: UIColor(patternImage: UIImage(named: "edit")!)) {
            (sender: MGSwipeTableCell!) -> Bool in
            
            print("Something has to happen")
            return true
        }

        
        
        cell.leftButtons = [editButton]
        cell.leftSwipeSettings.transition = .border
        
        
        cell.rightButtons = [deleteButton]
        cell.rightSwipeSettings.transition = .border
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func filterSubjectsActivity(subjectName: String){
        
        for activity in SingletonActivity.sharedInstance.tasks{
            
            if activity.subject?.title == subjectName{
                filteredActivityArray.append(activity)
            }
        }
    }

    
   func assignSubjectColor() -> UIColor {
        
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
        
        let subjectColor = [    customRed,
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
        
        let randomNumber = Int(arc4random_uniform(11))
        
        return subjectColor[randomNumber]
    }
    
    
    
    // MARK: - Persist subject
    
    
    func saveSubjects() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(subjects, forKey: "Subjects")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    
    }
    
    internal func loadSubjects() {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
        }
    }
    
 
    
    internal func returnSubjects() -> [Subject] {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            subjects = unarchiver.decodeObject(forKey: "Subjects") as! [Subject]
            unarchiver.finishDecoding()
            
        }
        
        return subjects        
    }
    
    internal func documentsDirectory() -> URL {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    
    internal func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Subjects.plist")
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "subjectCreated" {
            
            if let toViewController = segue.destination as? TempController {
                toViewController.data = subjectTextField.text!
                toViewController.segueData = segueData
            }
        }else if segue.identifier == "BackToSubjectChoice"{
            if let goBackToSubjectChoice = segue.destination as? ChooseSubjectController{
                goBackToSubjectChoice.segueRecived = self.segueData!
            }
        }else if segue.identifier == "ShowASubject"{
            
            if let showActivities = segue.destination as? ShowSubjectsActivity{
                showActivities.receivedArray = self.filteredActivityArray
                showActivities.subjectReceived = self.subjectInRow
            }
        }

    }
    
    


}
