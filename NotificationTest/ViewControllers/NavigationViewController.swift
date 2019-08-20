//
//  NavigationViewController.swift
//  NotificationTest
//
//  Created by Henrik on 2019-08-20.
//  Copyright © 2019 Henrik. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    @IBAction func goToDiary(_ sender: Any) {
    }
    @IBOutlet weak var goToDiary: UIButton!
    
    @IBAction func goToNote(_ sender: Any) {
    }
    @IBOutlet weak var goToNote: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToNote.commonButtonStyle()
        goToDiary.commonButtonStyle()

    }
    


}
