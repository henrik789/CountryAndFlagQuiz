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
    var timeNumber = 60
    var flagNumber = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sliderA.tintColor = UIColor(named: "ButtonTint")
        sliderA.thumbTintColor = UIColor(named: "Greyish")
        sliderB.tintColor = UIColor(named: "ButtonTint")
        sliderB.thumbTintColor = UIColor(named: "Greyish")
        labelB.text = String(sliderA.value)
        labelD.text = String(sliderB.value)
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

