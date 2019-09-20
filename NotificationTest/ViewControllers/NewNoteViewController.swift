
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
    @IBOutlet var headlineTextView: UITextView!
    @IBOutlet weak var newNoteTextView: UITextView!
    
    @IBAction func writeNoteButton(_ sender: Any) {
        view.addSubview(newNoteView)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            self.newNoteView.alpha = 1
            self.newNoteView.backgroundColor = UIColor.white
            self.newNoteView.frame = CGRect(x: 10, y: 20, width: self.screenWidth - 20, height: self.screenHeight / 4)
            self.newNoteView.layer.cornerRadius = 20
            self.newNoteView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            }) { _ in
            }
        newNoteView.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(NewNoteViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        self.newNoteView.addGestureRecognizer(tapGesture)
    }
    
    @IBOutlet weak var writeNoteButton: UIButton!
    @IBOutlet weak var saveToCloud: UIButton!
    @IBAction func saveToCloud(_ sender: Any) {
        cloudManager.trainingValue = Int32(sliderTraining.value)
        cloudManager.alcoholValue = Int32(sliderAlcohol.value)
        cloudManager.headlineText = headlineTextView.text
        cloudManager.dailynoteText = newNoteTextView.text
        cloudManager.saveToCloud()
    }
    @IBAction func writeNote(_ sender: Any) {
        
    }
    
    @IBAction func slideAlcoholValueChanged(_ sender: Any) {
        cloudManager.alcoholValue = Int32(sliderAlcohol.value)
    }
    @IBAction func slideTrainingValueChanged(_ sender: Any) {
        cloudManager.trainingValue = Int32(sliderTraining.value)
    }
    @IBAction func slideFoodValueChanged(_ sender: Any) {
        cloudManager.foodValue = Int32(sliderFood.value)
    }
    @IBAction func slideStressValueChanged(_ sender: Any) {
        cloudManager.stressValue = Int32(sliderStress.value)
    }
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardConfig()
        initConfig()
    }
    

    func initConfig() {
        writeNoteButton.layer.cornerRadius = writeNoteButton.bounds.width / 2
        saveToCloud.layer.cornerRadius = saveToCloud.bounds.width / 2

    }
    
    func setLabel(name: String, label: UILabel) {
        DispatchQueue.main.async {
            label.text = name
        }
    }
    
    @objc func removeViewFromSuperView() {
        if let subView = self.newNoteView{
            subView.removeFromSuperview()
            print("tar bort")
        } else {
            print("ikke!!")
            return
            
        }
    }
    
    
}

extension NewNoteViewController: UITextViewDelegate {
    func textViewShouldReturn(_ textview: UITextView) -> Bool {
        textview.resignFirstResponder()
        return true
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
    
    func keyboardConfig() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func animatePopUp(view: UIView, screenWidth: CGFloat, screenHeight: CGFloat){
        view.addSubview(view)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            view.alpha = 1
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: 10, y: 200, width: screenWidth - 20, height: screenHeight / 5)
            view.layer.cornerRadius = 20
            view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            let snowView = SnowView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//            let snowClipView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//            snowClipView.clipsToBounds = true
//            snowClipView.addSubview(snowView)
//            view.addSubview(snowClipView)
            
        }) { _ in
            

        }
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
