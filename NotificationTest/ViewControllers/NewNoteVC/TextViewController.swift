

import UIKit

class TextViewController: UIViewController {
    


    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    var saveToCloud = SaveToCloud()
    @IBAction func saveButton(_ sender: Any) {
        guard  let newNote = textView.text else { return }
        saveToCloud.saveToCloud(note: newNote)
    }
    
    @objc func dismissKeybard() {
        textView.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeybard))
        view.addGestureRecognizer(tap)
        
        saveButton.commonButtonStyle()
    }

    func setupTextView() {
        
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeybard))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
    }

}
