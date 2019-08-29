

import UIKit


class NewNoteViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    

    @objc func adjustInsetForKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let show = (notification.name == UIResponder.keyboardWillShowNotification)
            ? true
            : false
        
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.textContainer.heightTracksTextView = true
        textView.isScrollEnabled = false
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
