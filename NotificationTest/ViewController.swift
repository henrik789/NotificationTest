

import UIKit
import UserNotifications



class ViewController: UIViewController {

    var notification = Notification()
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var inputButton: UIButton!
    @IBAction func inputButton(_ sender: Any) {
        if let message = inputText.text {
            notification.executeNotification(message: message)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputButton.layer.cornerRadius = 20
    }
    
}

