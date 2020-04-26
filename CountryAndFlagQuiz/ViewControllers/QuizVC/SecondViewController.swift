
import UIKit

class SecondViewController: UIViewController {
    
    var givenLand = String()
    var landFullname = String()
    var getFlags = GetFlags()
    var points: Int = 0
    var flagCounter = 0
    var flagLimit = 100
    var randomNumber = 0
    var answer = String()
    var time = 0
    var progress = Progress(totalUnitCount: 1)
    var list = [Country]()
    var storageController = StorageController()
    var highscore = 0
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var countdownLabelHome: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var landOne: UIButton!
    @IBOutlet weak var landTwo: UIButton!
    @IBOutlet weak var landThre: UIButton!
    @IBOutlet weak var landFour: UIButton!
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func restartBtn(_ sender: Any) {
        startFresh()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func landOne(_ sender: Any) {
        let buttonOne = sender
        evaluate(button: buttonOne as! UIButton)
    }
    @IBAction func landTwo(_ sender: Any) {
        let buttonTwo = sender
        evaluate(button: buttonTwo as! UIButton)
    }
    @IBAction func landThree(_ sender: Any) {
        let buttonThree = sender
        evaluate(button: buttonThree as! UIButton)
    }
    @IBAction func landFour(_ sender: Any) {
        let buttonFour = sender
        evaluate(button: buttonFour as! UIButton)
    }
    @IBAction func newFlag(_ sender: Any) {
        givenLand = getFlags.buildFlagArray()
        flagCounter += 1
        flagImage.image = UIImage(named: givenLand + ".png")
        setCountryName(land: givenLand)
        flagLabel.text = "Flags: \(flagCounter) / \(flagLimit)"
        if points > highscore {
            save()
        }
    }
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBAction func mainBtn(_ sender: Any) {
        startFresh()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFlags.buildArray()
        config()
    }
    
    
    func config() {
        guard let user = StorageController.shared.fetchUser() else { return }
        flagLimit = user.flagCount
        highscore = user.pointsFlagQuiz
        progress = Progress(totalUnitCount: Int64(flagLimit))
        progressView.progressTintColor = UIColor(named: "Blueish")
        progressView.trackTintColor = UIColor(named: "Greyish")
        flagLabel.text = "Flags: \(flagCounter)/\(flagLimit)"
        pointsLabel.text = "Points: \(points)/\(flagLimit)"
        landOne.commonStyle()
        landTwo.commonStyle()
        landThre.commonStyle()
        landFour.commonStyle()
        mainBtn.mainStyle()
        
        newFlag((Any).self)
        flagLabel.adjustsFontSizeToFitWidth = true
        pointsLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setCountryName(land: String) {
        answer = getFlags.checkCountry(landCode: land)
        randomNumber = Int.random(in: 1...4)
        if randomNumber == 1 {
            landOne.setTitle(answer, for: .normal)
            setOtherNames(fake1: landTwo, fake2: landThre, fake3: landFour)
        } else if randomNumber == 2 {
            landTwo.setTitle(answer, for: .normal)
            setOtherNames(fake1: landOne, fake2: landThre, fake3: landFour)
        } else if randomNumber == 3 {
            landThre.setTitle(answer, for: .normal)
            setOtherNames(fake1: landOne, fake2: landTwo, fake3: landFour)
        } else if randomNumber == 4 {
            landFour.setTitle(answer, for: .normal)
            setOtherNames(fake1: landOne, fake2: landTwo, fake3: landThre)
        }
    }
    
    func setOtherNames(fake1: UIButton, fake2: UIButton, fake3: UIButton) {
        
        var numberOne = Int.random(in: 0..<getFlags.totalFlags.count)
        var land1 = getFlags.buildFlagArray1(number: numberOne)
        while land1 == givenLand {
            numberOne = Int.random(in: 0..<getFlags.totalFlags.count)
            land1 = getFlags.buildFlagArray1(number: numberOne)
        }
        var numberTwo = Int.random(in: 0..<getFlags.totalFlags.count)
        var land2 = getFlags.buildFlagArray1(number: numberTwo)
        while numberTwo == numberOne || land2 == givenLand {
            numberTwo = Int.random(in: 0..<getFlags.totalFlags.count)
            land2 = getFlags.buildFlagArray1(number: numberTwo)
        }
        var numberThree = Int.random(in: 0..<getFlags.totalFlags.count)
        var land3 = getFlags.buildFlagArray1(number: numberThree)
        while numberThree == numberTwo || numberThree == numberOne || land3 == givenLand {
            numberThree = Int.random(in: 0..<getFlags.totalFlags.count)
            land3 = getFlags.buildFlagArray1(number: numberThree)
        }
        let fakeAnswer1 = getFlags.checkCountry(landCode: land1)
        fake1.setTitle(fakeAnswer1, for: .normal)
        let fakeAnswer2 = getFlags.checkCountry(landCode: land2)
        fake2.setTitle(fakeAnswer2, for:  .normal)
        let fakeAnswer3 = getFlags.checkCountry(landCode: land3)
        fake3.setTitle(fakeAnswer3, for:  .normal)
    }
    
    
    func evaluate(button: UIButton) {
        if flagCounter <= flagLimit {
            if button.currentTitle == answer {
                
                UIView.transition(with: button, duration: 0.3, options: .curveEaseOut, animations: {
                    button.backgroundColor = UIColor(named: "Greeney")
                    button.setTitleColor(UIColor(named: "Whiteish"), for: .normal)
                })  { _ in
                    self.points = self.points + 1
                    self.pointsLabel.text = "Points: \(self.points)"
                    self.winAnimation()
                    if self.flagCounter != self.flagLimit {
                        self.newFlag((Any).self)
                    }
                    button.backgroundColor = UIColor(named: "Beigey")
                    button.setTitleColor(UIColor(named: "ButtonTint"), for: .normal)
                }
            }else {
                UIView.transition(with: button, duration: 0.3, options: .curveEaseOut, animations: {
                    button.backgroundColor = UIColor(named: "Redish")
                    button.setTitleColor(UIColor(named: "Whiteish"), for: .normal)
                })  { _ in
                    button.backgroundColor = UIColor(named: "Beigey")
                    button.setTitleColor(UIColor(named: "ButtonTint"), for: .normal)
                    if self.randomNumber == 1 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landOne.backgroundColor = UIColor(named: "Greeney")
                            self.landOne.setTitleColor(UIColor(named: "Whiteish"), for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landOne.backgroundColor = UIColor(named: "Beigey")
                            self.landOne.setTitleColor(UIColor(named: "ButtonTint"), for: .normal)
                        }
                    } else if self.randomNumber == 2 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landTwo.backgroundColor = UIColor(named: "Greeney")
                            self.landTwo.setTitleColor(UIColor(named: "Whiteish"), for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landTwo.backgroundColor = UIColor(named: "Beigey")
                            self.landTwo.setTitleColor(UIColor(named: "ButtonTint"), for: .normal)
                        }
                    }else if self.randomNumber == 3 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landThre.backgroundColor = UIColor(named: "Greeney")
                            self.landThre.setTitleColor(UIColor(named: "Whiteish"), for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landThre.backgroundColor = UIColor(named: "Beigey")
                            self.landThre.setTitleColor(UIColor(named: "ButtonTint"), for: .normal)
                        }
                    } else if self.randomNumber == 4 {
                        UIView.transition(with: button, duration: 0.8, options: .curveEaseOut, animations: {
                            self.landFour.backgroundColor = UIColor(named: "Greeney")
                            self.landFour.setTitleColor(UIColor(named: "Whiteish"), for: .normal)
                        })  { _ in
                            self.newFlag((Any).self)
                            self.landFour.backgroundColor = UIColor(named: "Beigey")
                            self.landFour.setTitleColor(UIColor(named: "ButtonTint"), for: .normal)
                        }
                    }
                }
                pointsLabel.shake()
            }
        }
        incrementProgress()
        if flagCounter == flagLimit {
            startOver()
        }
    }
    
    func incrementProgress() {
        progress.completedUnitCount += 1
        let progressFloat = Float(progress.fractionCompleted)
        progressView.setProgress(progressFloat, animated: true)
    }
    
    func startOver() {
        //        pointsLabel.text = "Points: \(points)/\(flagLimit)"
        //        timer.invalidate()
        let alert = UIAlertController(title: "Finished", message: "You have completed all flags. You scored \(points + 1) out of \(flagCounter).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.navigationController?.popViewController(animated: true)
            case .cancel: break
                
            case .destructive: break
                
            @unknown default:
                fatalError()
            }}))
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.startFresh()
            case .cancel: break
                
            case .destructive: break
                
            @unknown default:
                fatalError()
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func save() {
        var user = StorageController.shared.fetchUser()
        user?.pointsFlagQuiz = points
        storageController.save(user!)
    }
    
    func startFresh() {
        progressView.progress = 0
        points = 0
        pointsLabel.text = "Points: \(points)"
        flagCounter = 0
        flagLabel.text = "Flags: \(flagCounter)/\(flagLimit)"
        getFlags.buildArray()
        config()
    }
    
    @objc func update() {
        time += 1
        countdownLabelHome.text = "Time: " + String(time)
    }
    
    func winAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        })
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
}

