import UIKit

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

extension UILabel {
    
    func fontSizeAdjust(Adjustratio: String) {
        print(screenHeight)
        if screenHeight < 600 {
            switch Adjustratio {
            case "small":
                return font = font.withSize(screenHeight * 0.021)
            case "medium":
                return font = font.withSize(screenHeight * 0.025)
            case "large":
                return font = font.withSize(screenHeight * 0.058)
            default:
                return font = font.withSize(screenHeight * 0.028)
            }
        }else if screenHeight < 800 {
            switch Adjustratio {
            case "small":
                return font = font.withSize(screenHeight * 0.019)
            case "medium":
                return font = font.withSize(screenHeight * 0.024)
            case "large":
                return font = font.withSize(screenHeight * 0.050)
            default:
                return font = font.withSize(screenHeight * 0.028)
            }
        } else {
            print("big one")
            switch Adjustratio {
            case "small":
                return font = font.withSize(screenHeight * 0.018)
            case "medium":
                return font = font.withSize(screenHeight * 0.020)
            case "large":
                return font = font.withSize(screenHeight * 0.056)
            default:
                return font = font.withSize(screenHeight * 0.028)
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

