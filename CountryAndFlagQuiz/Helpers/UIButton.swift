
import UIKit


extension UIButton {
    func commonStyle() {
//        backgroundColor = UIColor(named: "Greyish")
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.init(named: "Beigey")?.cgColor
        layer.cornerRadius = 8
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
//        layer.shadowColor = UIColor.init(named: "Greyish")?.cgColor
//        layer.shadowOpacity = 0.3
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 3
        
    }
    
    func mainStyle() {
//        backgroundColor = UIColor(named: "Greyish")
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.init(named: "Blueish")?.cgColor
        layer.cornerRadius = 6
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
//        layer.shadowColor = UIColor.init(named: "Greyish")?.cgColor
//        layer.shadowOpacity = 0.3
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 3
    }
    
}
