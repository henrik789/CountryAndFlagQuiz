
import UIKit

class SettingsFlagViewController: UIViewController {
    
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var sliderA: UISlider!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var highscoreFlag: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var sliderB: UISlider!
    @IBOutlet weak var highscoreTime: UILabel!
    
    var storageController = StorageController()
    var flagNumber = 40
    var scoreFlag = 1
    var timeNumber = 30
    var scoreTime: Float = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        config()
    }
    
    
    func config() {
        let user = StorageController.shared.fetchUser()
        sliderA.tintColor = UIColor(named: "Whiteish")
        sliderA.thumbTintColor = UIColor(named: "Blueish")

        sliderA.setValue(Float(user?.flagCount ?? 100), animated: true)
        flagNumber = user?.flagCount ?? 100
        labelB.text = String(flagNumber)
        scoreFlag = user?.pointsFlagQuiz ?? 0
        highscoreFlag.text = "Highscore for FlagQuiz: \(scoreFlag)"
        
        sliderB.tintColor = UIColor(named: "Whiteish")
        sliderB.thumbTintColor = UIColor(named: "Blueish")

        sliderB.setValue(Float(user?.timeCount ?? 30), animated: true)
        timeNumber = user?.timeCount ?? 30
        labelD.text = String(timeNumber)
        scoreTime = user?.percentTimeQuiz ?? 0
        let twoDecimalPlaces = String(format: "%.2f", scoreTime)
        highscoreTime.text = "Highscore (Min. 4 Countries): \(twoDecimalPlaces)%"

    }
    
    @IBAction func dismissBtn(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        if let url = URL(string: "https://vexilloquiz.github.io/main/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func sliderA(_ sender: Any) {
        let step: Float = 10
        let roundedValue = round(sliderA.value / step) * step
        flagNumber = Int(roundedValue)
        labelB.text = String(flagNumber)
        save()
    }
    
    @IBAction func sliderB(_ sender: Any) {
        let step: Float = 5
        let roundedValue = round(sliderB.value / step) * step
        timeNumber = Int(roundedValue)
        labelD.text = String(timeNumber)
        save()
    }
    
    func save() {
        var user = StorageController.shared.fetchUser()
        user?.flagCount = flagNumber
        user?.timeCount = timeNumber
        storageController.save(user!)
    }
    
    
}

