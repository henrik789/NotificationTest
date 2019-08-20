
import UIKit

extension UIView {
    func commonStyle() {
//        layer.cornerRadius = layer.bounds.height / 5
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = CGSize(width: 1, height: -3)
//        layer.shadowRadius = 1.0
//        layer.masksToBounds = false
        let lightGrey = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        let blue = UIColor(red: 1.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        layer.borderColor = white.cgColor
        layer.borderWidth = 1
        layer.backgroundColor = white.cgColor
    }
}


