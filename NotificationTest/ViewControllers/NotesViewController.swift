

import UIKit
import UserNotifications



class NotesViewController: UIViewController {
    
    var cloudSave = SaveToCloud()
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBAction func refreshButton(_ sender: Any) {
    }
    @IBAction func showDiaryButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var headlineView: UIView!
    @IBOutlet weak var trainingView: UIView!
    @IBOutlet weak var alcoholView: UIView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var tobaccoView: UIView!
    @IBAction func saveButton(_ sender: Any) {
    }
    @IBOutlet weak var saveButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
    }
    
    
    func config() {
        tobaccoView.commonStyle()
        foodView.commonStyle()
        headlineView.commonStyle()
        trainingView.commonStyle()
        alcoholView.commonStyle()
        saveButton.commonButtonStyle()
    }
}

