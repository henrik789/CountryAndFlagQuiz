
import UIKit


extension UIButton {
    func commonStyle() {
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
        backgroundColor = .myWhite2
    }
    
    func mainStyle() {
        layer.cornerRadius = self.bounds.width / 9
        print(self.bounds.height, self.bounds.width)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowRadius = 3
        layer.borderColor = UIColor(named: "greyish")?.cgColor
        layer.borderWidth = 2
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
        layer.masksToBounds = true
    }
    
}
