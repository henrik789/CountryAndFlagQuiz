import UIKit

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

extension UILabel {
    
    func fontSizeAdjust(Adjustratio: String) {
        if screenHeight < 600 {
            switch Adjustratio {
            case "small":
                return font = font.withSize(14)
            case "medium":
                return font = font.withSize(17)
            case "large":
                return font = font.withSize(20)
            default:
                return font = font.withSize(16)
            }
        }else if screenHeight < 800 {
            switch Adjustratio {
            case "small":
                return font = font.withSize(16)
            case "medium":
                return font = font.withSize(19)
            case "large":
                return font = font.withSize(24)
            default:
                return font = font.withSize(16)
            }
        } else {
            print("big one")
            switch Adjustratio {
            case "small":
                return font = font.withSize(17)
            case "medium":
                return font = font.withSize(20)
            case "large":
                return font = font.withSize(26)
            default:
                return font = font.withSize(16)
            }
        }
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.98
        pulse.toValue = 0.99
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        layer.add(pulse, forKey: "pulse")
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 4, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 4, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
}

