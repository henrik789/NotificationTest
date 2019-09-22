
import UIKit

extension UIButton {
    func commonButtonStyle() {
        layer.cornerRadius = layer.bounds.height / 2
        frame.size.width = UIScreen.main.bounds.width / 2
        print("Resolution width: ", UIScreen.main.bounds.width / 2)
        print("Button width: ", frame.size.width)
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius:layer.cornerRadius).cgPath
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: 1, height: -3)
//        layer.shadowRadius = 3.0
//        layer.masksToBounds = false
        layer.borderColor = UIColor.bgColorThree.cgColor
        setTitleColor(UIColor.bgColorThree, for: .normal)
        layer.borderWidth = 1
//        layer.backgroundColor = .cgColor
    }
}

extension UIColor {
    
    static let bgColorOne = UIColor(red:0.36, green:0.73, blue:0.44, alpha:1.0)
    static let bgColorTwo = UIColor(red:0.24, green:0.64, blue:0.30, alpha:1.0)
    static let bgColorThree = UIColor(red:0.16, green:0.57, blue:0.20, alpha:1.0)
    static let blue = UIColor(red: 1.0/255.0, green: 100.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)

    
}
