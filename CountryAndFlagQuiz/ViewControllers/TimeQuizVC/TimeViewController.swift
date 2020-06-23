
import UIKit

class TimeViewController: UIViewController {
    
    
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
    var countdownTimer: Timer?
    var totalTime = 10
    var timeFromStart:Int = 0
    var storageController = StorageController()
    var winPercent: Float = 1.0
    var highscore: Float = 1.0
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(flagImageView)
        mainButton.mainStyle()
        mainButton.setTitle("Start", for: .normal)
        navigationController?.navigationBar.isHidden = true
        self.title = "Time Challenge"
        labelTop.adjustsFontSizeToFitWidth = true
        labelTop.layer.masksToBounds = true
        labelTop.text = "Country 1"
        labelBottom.adjustsFontSizeToFitWidth = true
        labelBottom.layer.masksToBounds = true
        labelBottom.text = "Country 2"
        flagImageView.image = UIImage(named: "vexi_logo.png")
        mainButton.titleLabel?.fontSizeAdjust(Adjustratio: "small")
        timeLabel.fontSizeAdjust(Adjustratio: "small")
        pointsLabel.fontSizeAdjust(Adjustratio: "small")
        labelTop.fontSizeAdjust(Adjustratio: "medium")
        labelBottom.fontSizeAdjust(Adjustratio: "medium")
        
    }
    
    
    func config() {
        guard let user = StorageController.shared.fetchUser() else { return }
        totalTime = user.timeCount
        timeFromStart = user.timeCount
        highscore = user.percentTimeQuiz
        points = 0
        flagCounter = 0
        timeLabel.text = "Time: \(timeFormatted(totalTime))"
        pointsLabel.text = "Points: \(points)"
        progress = Progress(totalUnitCount: Int64(totalTime))
        countryList = getFlags.readJSONFromFile()
        
        progressView.progress = 0
        startNewGame()
        setupLabelTap()
        startTimer()
        mainButton.setTitle("Restart", for: .normal)
    }
    
    // Game ******************************************************************************************************
    
    func startNewGame() {
        
        let randomCountry = Int.random(in: 0..<countryList.count)
        var fakeCountry = Int.random(in: 0..<countryList.count)
        while fakeCountry == randomCountry {
            fakeCountry = Int.random(in: 0..<countryList.count)
        }
        
        var flag = countryList[randomCountry].flagUrl
        flag = flag.replacingOccurrences(of: ".", with: "")
        if let imageToShow = UIImage(named: "\(flag).png") {
            flagImageView.image = imageToShow
        }
        
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
        guard countdownTimer == nil else {return}
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        countdownTimer?.tolerance  = 0.3
    }
    
    @objc func updateTime() {
        if totalTime > 0  && countryList.count > 1{
            totalTime -= 1
            incrementProgress()
            timeLabel.text = "Time: \(timeFormatted(totalTime))"
        } else {
            endTimer()
            endGame()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if countdownTimer != nil {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    func endTimer() {
        if countdownTimer != nil {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    func endGame() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 100
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        let percent = formatter.string(from: NSNumber(value: Float(points) / Float(flagCounter - 1)))
        winPercent = 100 * (Float(points) / Float(flagCounter - 1))
        mainButton.setTitle("Try Again", for: .normal)
        if points > 0 {
            labelTop.text = "You scored \(points)/\(flagCounter - 1) points in \(timeFromStart) seconds. \n Correct answers: \(percent!)"
            
        } else {
            labelTop.text = "You scored \(points)/\(flagCounter - 1) points in \(timeFromStart) seconds. \n Correct answers: 0"
        }
        labelBottom.isUserInteractionEnabled = false
        labelTop.isUserInteractionEnabled = false
        flagImageView.image = UIImage(named: "vexi_logo.png")
        if winPercent > highscore  && flagCounter >= 4 {
            save()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        endTimer()
        endGame()
        config()
    }
    
    func save() {
        var user = StorageController.shared.fetchUser()
        user?.percentTimeQuiz = winPercent
        storageController.save(user!)
    }
    
    func winAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.pointsLabel.layer.cornerRadius = 8
        })
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseInOut, animations: {
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.pointsLabel.layer.cornerRadius = 0
        })
    }
    
}
