
import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var belowLabel: UILabel!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.fontSizeAdjust(Adjustratio: "medium")
        belowLabel.fontSizeAdjust(Adjustratio: "medium")
    }

    
    
}

