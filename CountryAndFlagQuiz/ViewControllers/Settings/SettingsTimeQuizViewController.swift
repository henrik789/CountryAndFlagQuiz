//
//import UIKit
//
//class SettingsTimeQuizViewController: UIViewController {
//    
//
//    @IBOutlet weak var labelD: UILabel!
//    @IBOutlet weak var sliderB: UISlider!
//    @IBOutlet weak var highscoreTime: UILabel!
//    @IBOutlet weak var back: UIButton!
//    
//    
//    var storageController = StorageController()
//    var timeNumber = 30
//    var scoreTime: Float = 1.0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        config()
//    }
//    
//    @IBAction func back(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func config() {
////        @available(iOS 13.0, *
//        if #available(iOS 13.0, *) {
//          print("iOS 9.0 and greater")
//            back.isHidden = true
//        } else {
//          print("iOS 8.4")
//        }
//
//        let user = StorageController.shared.fetchUser()
//        sliderB.tintColor = UIColor(named: "Whiteish")
//        sliderB.thumbTintColor = UIColor(named: "Whiteish")
//
//        sliderB.setValue(Float(user?.timeCount ?? 30), animated: true)
//        timeNumber = user?.timeCount ?? 30
//        labelD.text = String(timeNumber)
//        scoreTime = user?.percentTimeQuiz ?? 0
//        highscoreTime.text = "Highscore for TimeQuiz: \(scoreTime)%"
//    }
//    
//    @IBAction func sliderB(_ sender: Any) {
//        let step: Float = 5
//        let roundedValue = round(sliderB.value / step) * step
//        timeNumber = Int(roundedValue)
//        labelD.text = String(timeNumber)
//        save()
//    }
//    
//    func save() {
//        var user = StorageController.shared.fetchUser()
//        user?.timeCount = timeNumber
//        storageController.save(user!)
//    }
//    
//    
//}
//
