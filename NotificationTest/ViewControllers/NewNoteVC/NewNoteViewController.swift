
import Macaw
import UIKit
import CloudKit

class NewNoteViewController: UIViewController {
    
    var diaryVC = DiaryViewController()
    var cloudManager = CloudManager()
    var notes = [CKRecord]()
    var timer = Timer()
    let dateFormatter = DateFormatter()

    var autoSize = true
    let headlineFont = UIFont.preferredFont(forTextStyle: .headline)
    let subheadFont = UIFont.preferredFont(forTextStyle: .subheadline)
    @IBOutlet weak var headlineLabel: UILabel!

    @IBOutlet weak var diaryButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet var newNoteTextView: UITextView!
    @IBOutlet var newNoteView: UIView!
    @IBOutlet var headlineTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func writeNoteButton(_ sender: Any) {
        
        view.addSubview(newNoteView)
        
        self.navigationController?.navigationBar.layer.zPosition = -1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.newNoteView.center.x = self.view.center.x
            self.newNoteView.alpha = 1
            self.newNoteView.layer.borderColor = UIColor.black.cgColor
            self.newNoteView.layer.borderWidth = 1
            self.newNoteView.frame = CGRect(x: self.screenWidth * 0.05, y: self.screenWidth * 0.1, width: self.screenWidth * 0.9, height: self.screenHeight / 2)
            self.newNoteView.layer.cornerRadius = 20
            //            self.newNoteView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }) { _ in
            
        }
        newNoteView.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(NewNoteViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        newNoteView.addGestureRecognizer(tapGesture)
        newNoteTextView.translatesAutoresizingMaskIntoConstraints = false
        newNoteTextView.isScrollEnabled = true
    }
    
    @IBOutlet weak var writeNoteButton: UIButton!
    @IBOutlet weak var saveToCloud: UIButton!
    @IBAction func saveToCloud(_ sender: Any) {
        
//        let noteDate = UserDefaults.standard.object(forKey: "lastNoteEntry") as! Date
//        let saveDate = dateFormatter.string(from: noteDate)
        
//        if canSave() {

//            cloudManager.headlineText = headlineTextView.text
            cloudManager.dailynoteText = newNoteTextView.text
            UserDefaults.standard.set(Date(), forKey:"lastNoteEntry")
            let noteDate = UserDefaults.standard.object(forKey: "lastNoteEntry") as! Date
            let saveDate = dateFormatter.string(from: noteDate)
            cloudManager.saveToCloud()
            
            let alert = UIAlertController(title: "Success!", message: "Your note was saved successfully. \n\(saveDate)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to Journal", style: .default, handler: { action in
                switch action.style{
                case .default:
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goToJournal", sender: nil)
                    }
                    
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    fatalError()
                }}))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    fatalError()
                }}))
            self.present(alert, animated: true, completion: nil)
//        } else {
//            let noteDate = UserDefaults.standard.object(forKey: "lastNoteEntry") as! Date
//            let saveDate = dateFormatter.string(from: noteDate)
//            let alert = UIAlertController(title: "Couldn't save", message: "Your last save was less than 24 hours ago. You're only allowed one note per day. Last note was saved: \(saveDate)", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Go to Journal", style: .default, handler: { action in
//                switch action.style{
//                case .default:
//                    self.performSegue(withIdentifier: "goToJournal", sender: nil)
//                case .cancel:
//                    print("cancel")
//                case .destructive:
//                    print("destructive")
//                @unknown default:
//                    fatalError()
//                }}))
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                switch action.style{
//                case .default:
//                    print("default")
//                case .cancel:
//                    print("cancel")
//                case .destructive:
//                    print("destructive")
//                @unknown default:
//                    fatalError()
//                }}))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
        newNoteView.removeFromSuperview()
    }
    
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
//    func canSave() -> Bool{
//        let noteDate = UserDefaults.standard.object(forKey: "lastNoteEntry") as! Date
//        let now = Date()
//        let ifAbleToSave = UserDefaults.standard.bool(forKey: "ifAbleToSave")
//
//        if ifAbleToSave {
//            UserDefaults.standard.set(false, forKey: "ifAbleToSave")
//            return true
//        } else {
//        let difference = Int(now.timeIntervalSince1970 - noteDate.timeIntervalSince1970) / 3600
//        print(difference)
//        if difference >= 1 {
//            return true
//        }else{
//            return false
//        }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initConfig()
    }
    
    
    func initConfig() {
        
        writeNoteButton.layer.borderWidth = 1
        writeNoteButton.layer.borderColor = UIColor.bgColorOne.cgColor
        writeNoteButton.backgroundColor = UIColor.clear
        writeNoteButton.layer.cornerRadius = writeNoteButton.frame.height / 2
        writeNoteButton.setTitleColor(UIColor.bgColorOne, for: .normal)
        saveToCloud.layer.borderWidth = 1
        saveToCloud.layer.borderColor = UIColor.bgColorThree.cgColor
        saveToCloud.layer.cornerRadius = saveToCloud.frame.height / 2
        saveToCloud.backgroundColor = UIColor.clear
        saveToCloud.setTitleColor(UIColor.bgColorThree, for: .normal)
        newNoteTextView.delegate = self
        newNoteTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))

        UserDefaults.standard.register(defaults: ["ifAbleToSave" : true])
        UserDefaults.standard.register(defaults: ["lastNoteEntry" : Date()])
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "sv")
        infoButton.setTitleColor(UIColor.bgColorFour, for: .normal)
        infoButton.layer.cornerRadius = infoButton.frame.height / 2
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = UIColor.bgColorFour.cgColor
        infoButton.backgroundColor = UIColor.clear
        diaryButton.setTitleColor(UIColor.bgColorFive, for: .normal)
        diaryButton.layer.cornerRadius = diaryButton.frame.height / 2
        diaryButton.layer.borderWidth = 1
        diaryButton.layer.borderColor = UIColor.bgColorFive.cgColor
        diaryButton.backgroundColor = UIColor.clear
        
    }
    
    
    @objc func removeViewFromSuperView() {
        if let subView = self.newNoteView{
            subView.removeFromSuperview()
            self.navigationController?.navigationBar.layer.zPosition = 0
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
                
            } else {
                newNoteTextView.resignFirstResponder()
                newNoteView.removeFromSuperview()
                self.navigationController?.navigationBar.layer.zPosition = 0
            }
        }
//        else if textView == headlineTextView {
//            if headlineTextView.text.count > 40 {
//                headlineTextView.resignFirstResponder()
//            }
        }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
        newNoteView.removeFromSuperview()
        self.navigationController?.navigationBar.layer.zPosition = 0
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if headlineTextView.text == "\n"
//        {
//            headlineTextView.resignFirstResponder()
//            return false
//        }
//        return true
//    }

    
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

