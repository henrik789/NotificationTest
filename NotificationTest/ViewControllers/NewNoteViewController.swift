
import Macaw
import UIKit

class NewNoteViewController: UIViewController {
    
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var timer = Timer()
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var sliderOne: UISlider!
    @IBOutlet weak var anilabel: UILabel!
    @IBAction func slideOneValueChanged(_ sender: Any) {
        labelOne.text = "Slidervalue: \(sliderOne.value)"
        runTimer(value: Int(sliderOne.value))
    }
    
    
    @objc func adjustInsetForKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let show = (notification.name == UIResponder.keyboardWillShowNotification)
            ? true
            : false
        
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        //        scrollView.contentInset.bottom += adjustmentHeight
        //        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        let name = "Henriks COREDATA"
        let user = Journal(context: context)
        user.dailyNote = name
        appdelegate.saveContext()
        print(user.dailyNote)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //        textView.textContainer.heightTracksTextView = true
        //        textView.isScrollEnabled = false
        //        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func runTimer(value: Int) {
        var i: Int = 0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            i += 1
            self.anilabel.text = String(i)
            if i == value || i < 1 || i > 99 {
                timer.invalidate()
                self.setLabel(name: "Ready", label: self.anilabel)
            }
        }
        
    }
    
    func setLabel(name: String, label: UILabel) {
        DispatchQueue.main.async {
            label.text = name
        }
    }
    
    
    
    
}

extension NewNoteViewController: UITextViewDelegate {
    func textViewShouldReturn(_ textview: UITextView) -> Bool {
        textview.resignFirstResponder()
        return true
    }
}
