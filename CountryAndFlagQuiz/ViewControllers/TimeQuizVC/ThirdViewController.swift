
import UIKit

class ThirdViewController: UIViewController {
    
    
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var progress = Progress(totalUnitCount: 10)
    var getFlags = GetFlags()
    var countryList = [Country]()
    var right = false
    var points: Int = 0
    var flagCounter = 0
    var countdownTimer: Timer!
    var totalTime = 10
    var timeFromStart:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(flagImageView)
        view.backgroundColor = UIColor(named: "Whiteish")
        mainButton.mainStyle()
        mainButton.setTitle("Start", for: .normal)
        self.title = "Time Challenge"
        labelTop.layer.cornerRadius = 10
        labelTop.adjustsFontSizeToFitWidth = true
        labelTop.layer.masksToBounds = true
        labelTop.text = "Country 1 or"
        labelBottom.layer.cornerRadius = 10
        labelBottom.adjustsFontSizeToFitWidth = true
        labelBottom.layer.masksToBounds = true
        labelBottom.text = "Country 2?"
        flagImageView.image = UIImage(named: "logoShape_Blue.png")
    }
    
    func config() {
        guard let user = StorageController.shared.fetchUser() else { return }
        totalTime = user.timeCount
        timeFromStart = user.timeCount
        timeLabel.text = "Time: \(timeFormatted(totalTime))"
        pointsLabel.text = "Points: \(points)"
        progress = Progress(totalUnitCount: Int64(totalTime))
        countryList = getFlags.readJSONFromFile()
        points = 0
        flagCounter = 0
        progressView.progress = 0
        startNewGame()
        startTimer()
    }
    
    // Game ******************************************************************************************************
    
    func startNewGame() {
        setupLabelTap()
        let randomCountry = Int.random(in: 0..<countryList.count)
        var fakeCountry = Int.random(in: 0..<countryList.count)
        while fakeCountry == randomCountry {
            fakeCountry = Int.random(in: 0..<countryList.count)
        }
        
        var flag = countryList[randomCountry].flagUrl
        flag = flag.replacingOccurrences(of: ".", with: "")
        flagImageView.image = UIImage(named: "\(flag).png") ?? UIImage(named: "logoShape_Blue.png")
        if randomCountry % 2 == 0 {
            labelTop.text = "Capital: \(countryList[randomCountry].capital) \n Population: \(formatNumber(bigNumber: countryList[randomCountry].population))"
            labelBottom.text = "Capital: \(countryList[fakeCountry].capital) \n Population: \(formatNumber(bigNumber: countryList[fakeCountry].population))"
            right = true
            countryList.remove(at: randomCountry)
        } else {
            labelTop.text = "Capital: \(countryList[fakeCountry].capital) \n Population: \(formatNumber(bigNumber: countryList[fakeCountry].population))"
            labelBottom.text = "Capital: \(countryList[randomCountry].capital) \n Population: \(formatNumber(bigNumber: countryList[randomCountry].population))"
            right = false
            countryList.remove(at: randomCountry)
        }
        flagCounter += 1
        mainButton.setTitle("Restart", for: .normal)
    }
    
    func setupLabelTap() {
        let leftLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.leftlabelTapped(_:)))
        self.labelBottom.isUserInteractionEnabled = true
        self.labelBottom.addGestureRecognizer(leftLabelTap)
        let rightLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.rightabelTapped(_:)))
        self.labelTop.isUserInteractionEnabled = true
        self.labelTop.addGestureRecognizer(rightLabelTap)
    }
    
    @objc func leftlabelTapped(_ sender: UITapGestureRecognizer) {
        if !right {
            points += 1
            pointsLabel.text = "Points: \(points)"
            winAnimation()
            self.startNewGame()
        } else {
            pointsLabel.shake()
            self.startNewGame()
        }
    }
    
    @objc func rightabelTapped(_ sender: UITapGestureRecognizer) {
        if right {
            points += 1
            pointsLabel.text = "Points: \(points)"
            winAnimation()
            self.startNewGame()
        } else {
            pointsLabel.shake()
            self.startNewGame()
        }
    }
    
    func incrementProgress() {
        progress.completedUnitCount += 1
        let progressFloat = Float(progress.fractionCompleted)
        progressView.setProgress(progressFloat, animated: true)
    }
    
    // Timer ************************************************************************************************
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        countdownTimer.tolerance  = 0.1
    }
    
    @objc func updateTime() {
        if totalTime > 0  && countryList.count > 1{
            totalTime -= 1
            incrementProgress()
            timeLabel.text = "Time: \(timeFormatted(totalTime))"
        } else {
            endTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if countdownTimer != nil {
            if countdownTimer.isValid {
            countdownTimer.invalidate()
            print("view disappear")
            }
        }
    }
    
    func endTimer() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 100
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        let percent = formatter.string(from: NSNumber(value: Float(points) / Float(flagCounter)))
        countdownTimer.invalidate()
        mainButton.setTitle("Try Again", for: .normal)
        labelTop.text = "You scored \(points)/\(flagCounter) points in \(timeFromStart) seconds. \n Correct answers: \(percent!)"
        
        labelBottom.isUserInteractionEnabled = false
        labelTop.isUserInteractionEnabled = false
        flagImageView.image = UIImage(named: "logoShape_Blue.png")
    }
    
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        if countdownTimer == nil {
            config()
        }else {
            if countdownTimer.isValid {
                endTimer()
                print(countdownTimer.isValid)
            }
            print("new game")
            config()
        }
//        config()
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
