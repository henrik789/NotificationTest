//
//  DiaryCollectionViewCell.swift
//  NotificationTest
//
//  Created by Henrik on 2019-08-20.
//  Copyright © 2019 Henrik. All rights reserved.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    static var identifier: String {
        return "DiaryCollectionViewCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = layer.bounds.height / 6
    }
    

}
