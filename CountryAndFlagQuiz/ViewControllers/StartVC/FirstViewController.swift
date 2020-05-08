
import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var subHead: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.fontSizeAdjust(Adjustratio: "small")
        subHead.fontSizeAdjust(Adjustratio: "small")
        bottomLabel.fontSizeAdjust(Adjustratio: "small")
    }

    
    
}

