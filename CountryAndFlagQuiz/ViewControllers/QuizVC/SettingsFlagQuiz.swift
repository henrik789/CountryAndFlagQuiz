
import UIKit

class SettingsFlagViewController: UIViewController {
    
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var sliderA: UISlider!

    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var highscoreFlag: UILabel!
    
    var storageController = StorageController()
    var flagNumber = 40
    var scoreFlag = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        config()
    }
    
    
    func config() {
        if #available(iOS 13.0, *) {
          print("iOS 9.0 and greater")
            dismissBtn.isHidden = true
        }
        let user = StorageController.shared.fetchUser()
        sliderA.tintColor = UIColor(named: "Whiteish")
        sliderA.thumbTintColor = UIColor(named: "Blueish")

        sliderA.setValue(Float(user?.flagCount ?? 100), animated: true)
        flagNumber = user?.flagCount ?? 100
        labelB.text = String(flagNumber)
        scoreFlag = user?.pointsFlagQuiz ?? 0
        highscoreFlag.text = "Highscore for FlagQuiz: \(scoreFlag)"

    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderA(_ sender: Any) {
        let step: Float = 10
        let roundedValue = round(sliderA.value / step) * step
        flagNumber = Int(roundedValue)
        labelB.text = String(flagNumber)
        save()
    }
    
    func save() {
        var user = StorageController.shared.fetchUser()
        user?.flagCount = flagNumber
        storageController.save(user!)
    }
    
    
}

