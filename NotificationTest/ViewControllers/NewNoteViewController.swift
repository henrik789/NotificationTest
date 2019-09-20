
import Macaw
import UIKit

class NewNoteViewController: UITableViewController {
    var diaryVC = DiaryViewController()
    var cloudManager = CloudManager()
    var timer = Timer()
    let headlineFont = UIFont.preferredFont(forTextStyle: .headline)
    let subheadFont = UIFont.preferredFont(forTextStyle: .subheadline)
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var sliderAlcohol: UISlider!
    @IBOutlet weak var sliderTraining: UISlider!
    @IBOutlet weak var sliderFood: UISlider!
    @IBOutlet weak var sliderStress: UISlider!
    @IBOutlet var newNoteView: UIView!
    @IBOutlet weak var newNoteTextView: UITextView!
    
    @IBAction func writeNoteButton(_ sender: Any) {
    }
    @IBOutlet weak var writeNoteButton: UIButton!
    @IBOutlet weak var saveToCloud: UIButton!
    @IBAction func saveToCloud(_ sender: Any) {
    }
    @IBAction func writeNote(_ sender: Any) {
    }
    
    @IBAction func slideAlcoholValueChanged(_ sender: Any) {
        var value = sliderAlcohol.value
    }
    @IBAction func slideTrainingValueChanged(_ sender: Any) {
        var value = sliderTraining.value
    }
    @IBAction func slideFoodValueChanged(_ sender: Any) {
        var value = sliderFood.value
    }
    @IBAction func slideStressValueChanged(_ sender: Any) {
        var value = sliderStress.value
    }
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let textColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1)
//        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: textColor,
//            .font: subheadFont,
//            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle]
//        let attributedString = NSAttributedString(string: "This title is attributed", attributes: attributes)
//        cloudLabel.attributedText = attributedString
//        cloudLabel.frame = CGRect(x: view.center.x, y: screenHeight * 0.1, width: screenWidth * 0.8, height: screenHeight * 0.08)
//        keyboardConfig()
//        cloudManager.saveToCloud(note: "Hej det funkar bra med ännu en enum")
    }
    
//    func runTimer(value: Int) {
//        var i: Int = 0
//        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
//            i += 1
//            self.anilabel.text = String(i)
//            if i == value || i < 1 || i > 99 {
//                timer.invalidate()
//                self.setLabel(name: "Ready", label: self.anilabel)
//            }
//        }
//    }
    
    func setLabel(name: String, label: UILabel) {
        DispatchQueue.main.async {
            label.text = name
        }
    }
    
    func keyboardConfig() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}

extension NewNoteViewController: UITextViewDelegate {
    func textViewShouldReturn(_ textview: UITextView) -> Bool {
        textview.resignFirstResponder()
        return true
    }
}
