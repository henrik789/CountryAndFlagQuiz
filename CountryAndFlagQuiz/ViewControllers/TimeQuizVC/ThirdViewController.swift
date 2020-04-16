//
//  ThirdViewController.swift
//  CountryAndFlagQuiz
//
//  Created by Henrik on 2020-03-29.
//  Copyright © 2020 Henrik. All rights reserved.
//

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
        var totalTime = 60
        var isPresented = ""

        
        override func viewDidLoad() {
            super.viewDidLoad()
            config()
//            guard let user = StorageController.shared.fetchUser() else { return }
            
//            timeLabel.text = String(user.timeCount)
//            totalTime = user.timeCount
            self.title = "Quiz B"
        }
        
        func config() {
            setupLabelTap()
            view.bringSubviewToFront(flagImageView)
            view.backgroundColor = UIColor(named: "Whiteish")
            mainButton.mainStyle()
            labelTop.layer.cornerRadius = 10
            labelTop.layer.masksToBounds = true
            labelBottom.layer.cornerRadius = 10
            labelBottom.layer.masksToBounds = true
            labelTop.backgroundColor = UIColor(named: "Beigey")
            labelBottom.backgroundColor = UIColor(named: "Beigey")
            countryList = getFlags.readJSONFromFile()
            points = 0
            pointsLabel.text = "Points: \(points)"
            startNewGame()
            startTimer()
            
        }
        
        @IBAction func mainButton(_ sender: Any) {
            self.viewDidLoad()
        }
        
        // Game ******************************************************************************************************
        func startNewGame() {
            
            let randomCountry = Int.random(in: 0..<countryList.count)

            var fakeCountry = Int.random(in: 0..<countryList.count)
            while fakeCountry == randomCountry {
                fakeCountry = Int.random(in: 0..<countryList.count)
                print("Error! game engine", randomCountry, fakeCountry)
            }
            
            var flag = countryList[randomCountry].flagUrl
            
            flag = flag.replacingOccurrences(of: ".", with: "")
            
            flagImageView.image = UIImage(named: "\(flag).png") ?? UIImage(named: "globe_white.png")
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
            print(randomCountry,  "image: \(flag)")
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
            countdownTimer.tolerance  = 0.3
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
            let alert = UIAlertController(title: "Finished", message: "You have completed all flags. You scored \(points) out of \(flagCounter).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    self.navigationController?.popViewController(animated: true)
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                @unknown default:
                    fatalError()
                }}))
            alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    self.viewDidLoad()
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                @unknown default:
                    fatalError()
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        
        func timeFormatted(_ totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            //     let hours: Int = totalSeconds / 3600
            return String(format: "%02d:%02d", minutes, seconds)
        }
        @IBAction func startTimerPressed(_ sender: UIButton) {
            startTimer()
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
