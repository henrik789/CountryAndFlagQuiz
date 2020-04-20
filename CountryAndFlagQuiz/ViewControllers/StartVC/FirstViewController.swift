//
//  FirstViewController.swift
//  CountryAndFlagQuiz
//
//  Created by Henrik on 2020-03-28.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var sliderA: UISlider!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var sliderB: UISlider!
    @IBOutlet var settingsView: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    
    var timeNumber = 60
    var flagNumber = 200
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        settingsView.center = view.center
        settingsView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            
            self.settingsView.alpha = 1
            self.settingsView.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
            self.settingsView.layer.cornerRadius = 14
            UIApplication.shared.keyWindow!.addSubview(self.settingsView)
            
        }) { _ in
            
            
        }
    }
    
    @objc func removeViewFromSuperView() {
        if let subView = self.settingsView{
            subView.removeFromSuperview()
            print("tar bort")
        } else {
            print("ikke!!")
            return
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let aSelector : Selector = #selector(FirstViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        settingsView.addGestureRecognizer(tapGesture)
        sliderA.tintColor = UIColor(named: "ButtonTint")
        sliderA.thumbTintColor = UIColor(named: "Greyish")
        sliderB.tintColor = UIColor(named: "ButtonTint")
        sliderB.thumbTintColor = UIColor(named: "Greyish")
        labelB.text = String(sliderA.value)
        labelD.text = String(sliderB.value)
        settingsButton.commonStyle()
    }
    @IBAction func sliderA(_ sender: Any) {
        let step: Float = 10
        let roundedValue = round(sliderA.value / step) * step
        flagNumber = Int(roundedValue)
        //        save()
        labelB.text = String(flagNumber)
    }
    
    @IBAction func sliderB(_ sender: Any) {
        let step: Float = 10
        let roundedValue = round(sliderB.value / step) * step
        timeNumber = Int(roundedValue)
        labelD.text = String(timeNumber)
        //        save()
    }
    
    
}

