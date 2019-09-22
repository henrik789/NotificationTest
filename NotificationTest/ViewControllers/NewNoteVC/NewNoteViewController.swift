
import Macaw
import UIKit

class NewNoteViewController: UITableViewController {
    
    var diaryVC = DiaryViewController()
    var cloudManager = CloudManager()
    var timer = Timer()
    var autoSize = true
    let headlineFont = UIFont.preferredFont(forTextStyle: .headline)
    let subheadFont = UIFont.preferredFont(forTextStyle: .subheadline)
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var sliderAlcohol: UISlider!
    @IBOutlet weak var sliderTraining: UISlider!
    @IBOutlet weak var sliderFood: UISlider!
    @IBOutlet weak var sliderStress: UISlider!
    @IBOutlet var newNoteTextView: UITextView!
    @IBOutlet var newNoteView: UIView!
    @IBOutlet var headlineTextView: UITextView!
    
    
    @IBAction func writeNoteButton(_ sender: Any) {
        
        view.addSubview(newNoteView)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
            self.newNoteView.alpha = 1
            self.newNoteView.backgroundColor = UIColor.white
            self.newNoteView.frame = CGRect(x: 10, y: 20, width: self.screenWidth - 20, height: self.screenHeight / 3)
            self.newNoteView.layer.cornerRadius = 20
            self.newNoteView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            self.newNoteView.backgroundColor = .yellow
        }) { _ in
            
        }
        newNoteView.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(NewNoteViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        newNoteView.addGestureRecognizer(tapGesture)
        //        newNoteTextView.translatesAutoresizingMaskIntoConstraints = true
        newNoteTextView.isScrollEnabled = false
        
        
        
    }
    
    @IBOutlet weak var writeNoteButton: UIButton!
    @IBOutlet weak var saveToCloud: UIButton!
    @IBAction func saveToCloud(_ sender: Any) {
        cloudManager.stressValue = Int32(sliderStress.value)
        cloudManager.foodValue = Int32(sliderFood.value)
        cloudManager.trainingValue = Int32(sliderTraining.value)
        cloudManager.alcoholValue = Int32(sliderAlcohol.value)
        cloudManager.headlineText = headlineTextView.text
        cloudManager.dailynoteText = newNoteTextView.text
        
        cloudManager.saveToCloud()
    }
    @IBAction func writeNote(_ sender: Any) {
        
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
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
        //        keyboardConfig()
        initConfig()
    }
    
    
    func initConfig() {
        writeNoteButton.layer.cornerRadius = 5
        saveToCloud.layer.cornerRadius = 5
        newNoteTextView.delegate = self
        headlineTextView.delegate = self
        headlineTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
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
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == newNoteTextView {
            countLabel.text = "\(400 - newNoteTextView.text.count)"
            if newNoteTextView.text.count < 400 {
                if autoSize {
                    let fixedWidth = newNoteView.frame.size.width
                    newNoteTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                    let newSize = newNoteTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                    var newFrame = newNoteTextView.frame
                    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                    newNoteTextView.frame = newFrame
                    print(newNoteTextView.frame.size.height, newNoteView.frame.size.height)
                    if newNoteTextView.frame.size.height >= newNoteView.frame.size.height - 30 {
                        autoSize = false
                    }
                } else {
                    newNoteTextView.isScrollEnabled = true
                    newNoteTextView.translatesAutoresizingMaskIntoConstraints = false
                }
            } else {
                newNoteTextView.resignFirstResponder()
                newNoteView.removeFromSuperview()
            }
        }
        else if textView == headlineTextView {
            //            print(headlineTextView.text)
            //            if (headlineTextView.text == "\n") {
            //                headlineTextView.resignFirstResponder()
            //            }
            if headlineTextView.text.count > 28 {
                headlineTextView.resignFirstResponder()
            }
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if headlineTextView.text == "\n"
        {
            headlineTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
}
extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
