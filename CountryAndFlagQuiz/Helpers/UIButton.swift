
import UIKit


extension UIButton {
    func commonStyle() {
        layer.cornerRadius = 8
        let shadowPath2 = UIBezierPath(rect: self.bounds)
//        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(2.0))
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath2.cgPath

    }
    
    func mainStyle() {
        layer.backgroundColor = UIColor.init(named: "ButtonTint")?.cgColor
        layer.cornerRadius = 4
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(2.0))
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false

    }
    
}
