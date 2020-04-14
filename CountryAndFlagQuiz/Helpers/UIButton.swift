
import UIKit


extension UIButton {
    func commonStyle() {
        layer.cornerRadius = 8
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        
    }
    
    func mainStyle() {
        //        layer.backgroundColor = UIColor.init(named: "ButtonTint")?.cgColor
        layer.cornerRadius = 6
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
    }
    
}
