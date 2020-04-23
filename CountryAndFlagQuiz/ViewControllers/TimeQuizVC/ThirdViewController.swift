
import UIKit

class ThirdViewController: UIViewController {
    
    
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
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
//        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.bringSubviewToFront(flagImageView)
        view.backgroundColor = UIColor(named: "Whiteish")
        mainButton.mainStyle()
        mainButton.setTitle("Start", for: .normal)
        self.title = "Time Challenge"
        labelTop.layer.cornerRadius = 10
        labelTop.layer.masksToBounds = true
        labelTop.text = "Country 1"
        labelBottom.layer.cornerRadius = 10
        labelBottom.layer.masksToBounds = true
        labelBottom.text = "Country 2"
        flagImageView.image = UIImage(named: "logoShape_Blue.png")
        setupLabels()
    }
    
    func setupLabels() {
        guard let user = StorageController.shared.fetchUser() else { return }
        totalTime = user.timeCount
        timeFromStart = user.timeCount
        timeLabel.text = "Time: \(timeFormatted(totalTime))"
        pointsLabel.text = "Points: \(points)"
    }
    
    func config() {
        setupLabels()
        countryList = getFlags.readJSONFromFile()
        points = 0
        flagCounter = 0
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
            print("Error! game engine", randomCountry, fakeCountry)
        }
        
        var flag = countryList[randomCountry].flagUrl
        
        flag = flag.replacingOccurrences(of: ".", with: "")
        
        flagImageView.image = UIImage(named: "\(flag).png") ?? UIImage(named: "logoShape_Blue.png")
        if randomCountry % 2 == 0 {
            labelTop.text = "Capital: \(countryList[randomCountry].capital) \n Population: \(formatNumber(bigNumber: countryList[randomCountry].population))"
            labelBottom.text = "Capital: \(countryList[fakeCountry].capital) \n Population: \(formatNumber(bigNumber: countryList[fakeCountry].population))"
            right = true
            countryList.remove(at: randomCountry)
            print(countryList.count, randomCountry)
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
        print("left labelTapped")
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
        print("right labelTapped")
        
    }
    
    
    // Timer ************************************************************************************************
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        countdownTimer.tolerance  = 0.1
    }
    
    @objc func updateTime() {
        timeLabel.text = "Time: \(timeFormatted(totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        mainButton.setTitle("Try Again", for: .normal)
        labelTop.text = "You scored \(points)/\(flagCounter) points in \(timeFromStart) seconds. \n "
        
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
        config()
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
