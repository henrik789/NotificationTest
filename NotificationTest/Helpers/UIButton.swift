
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

