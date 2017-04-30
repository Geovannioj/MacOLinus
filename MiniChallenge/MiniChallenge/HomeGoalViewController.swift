import UIKit
import UserNotifications

class HomeGoalViewController: UIViewController {

    //MARK - Labels & TextFields
    
    
    @IBOutlet weak var goalTitleField: UITextField!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalTitleLabell: UILabel!
    
    
    // MARK: - User Goals
    
    var userGoals = [Goal]()
    
    
    
    // MARK: - Default Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         createNotification()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }

    
    // MARK: - Actions
    
    @IBAction func buttonPressed(_ sender: Any) {
    
        setNotification(timeToNotificate: 5)
    }
    
    
    @IBAction func lala(_ sender: Any) {
        print("Pressed")
    }
    
    // MARK: - Notification
    
    func createNotification() {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in
            
        })
    }
    
    
    func setNotification(timeToNotificate: Int) {
        
        let daySeconds = 86400
        let alertSeconds = timeToNotificate * daySeconds
        
        
        let content = createNotificationContent()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(alertSeconds), repeats: false)
        let request = UNNotificationRequest(identifier: "goalNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    
    internal func createNotificationContent() -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.subtitle = "That's a notification"
        content.body = "Hey do you remember of ..."

        return content
    }
    
    // MARK: - Persist User goals data
    
    func saveUserGoals() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(userGoals, forKey: "UserGoals")
        archiver.finishEncoding()
        
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadUserGoals() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            userGoals = unarchiver.decodeObject(forKey: "UserGoals") as! [Goal]
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("UserGoals.plist")
    }
    
      
}
