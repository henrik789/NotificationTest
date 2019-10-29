
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
        layer.borderColor = UIColor.white.cgColor
        setTitleColor(UIColor.bgColorThree, for: .normal)
        layer.borderWidth = 1
//        layer.backgroundColor = .cgColor
    }
}

extension UIColor {
    
    static let bgColorOne = UIColor(red:0.71, green:0.20, blue:0.44, alpha:1.0)
    static let bgColorTwo = UIColor(red:0.07, green:0.54, blue:0.65, alpha:1.0)
    static let bgColorThree = UIColor(red:0.07, green:0.80, blue:0.77, alpha:1.0)
    static let bgColorFour = UIColor(red:0.97, green:0.62, blue:0.12, alpha:1.0)
    static let bgColorFive = UIColor(red:0.93, green:0.30, blue:0.40, alpha:1.0)
    static let blue = UIColor(red: 1.0/255.0, green: 100.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)

    
}
