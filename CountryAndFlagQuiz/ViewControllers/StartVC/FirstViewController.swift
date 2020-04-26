
import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var sliderA: UISlider!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var sliderB: UISlider!
    @IBOutlet var settingsView: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var highscoreFlag: UILabel!
    @IBOutlet weak var highscoreTime: UILabel!
    
    var storageController = StorageController()
    var timeNumber = 30
    var flagNumber = 40
    var scoreFlag = 1
    var scoreTime: Float = 1.0
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        config()
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        settingsView.center = view.center
        settingsView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
            
            self.settingsView.alpha = 1
            self.settingsView.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
            self.settingsView.layer.cornerRadius = 14
            UIApplication.shared.keyWindow!.addSubview(self.settingsView)
        })
    }
    
    @objc func removeViewFromSuperView() {
        if let subView = self.settingsView{
            subView.removeFromSuperview()
        } else {
            return
        }
    }
    
    func config() {
        let aSelector : Selector = #selector(FirstViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        let user = StorageController.shared.fetchUser()
        settingsView.addGestureRecognizer(tapGesture)
        sliderA.tintColor = UIColor(named: "Whiteish")
        sliderA.thumbTintColor = UIColor(named: "Blueish")
        sliderB.tintColor = UIColor(named: "Whiteish")
        sliderB.thumbTintColor = UIColor(named: "Blueish")
        
        sliderA.setValue(Float(user?.flagCount ?? 100), animated: true)
        sliderB.setValue(Float(user?.timeCount ?? 30), animated: true)
        flagNumber = user?.flagCount ?? 100
        timeNumber = user?.timeCount ?? 30
        labelB.text = String(flagNumber)
        labelD.text = String(timeNumber)
        scoreFlag = user?.pointsFlagQuiz ?? 0
        scoreTime = user?.percentTimeQuiz ?? 0
        highscoreFlag.text = "Highscore for FlagQuiz: \(scoreFlag))"
        highscoreTime.text = "Highscore for TimeQuiz: \(scoreTime)% "
        settingsButton.commonStyle()
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
        user?.timeCount = timeNumber
        user?.flagCount = flagNumber
        storageController.save(user!)
    }
    
    
}

