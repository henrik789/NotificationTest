//
//  NewNoteViewController.swift
//  NotificationTest
//
//  Created by Henrik on 2019-08-28.
//  Copyright © 2019 Henrik. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.textContainer.heightTracksTextView = true
        textView.isScrollEnabled = false
    }
    



}
