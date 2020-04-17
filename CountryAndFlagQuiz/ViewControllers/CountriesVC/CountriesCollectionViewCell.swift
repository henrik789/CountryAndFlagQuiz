//
//  CountriesCollectionViewCell.swift
//  CountryAndFlagQuiz
//
//  Created by Henrik on 2020-04-17.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

class CountriesCollectionViewCell: UICollectionViewCell {
        
        @IBOutlet weak var countrynameLabel: UILabel!
        @IBOutlet weak var capitalLabel: UILabel!
        @IBOutlet weak var regionLabel: UILabel!
        @IBOutlet weak var languageLabel: UILabel!
        @IBOutlet weak var currencyLabel: UILabel!
        @IBOutlet weak var populationLabel: UILabel!
        @IBOutlet weak var imageView: UIImageView!
//        @IBOutlet weak var mainView: UIView!
        @IBOutlet weak var subregionLabel: UILabel!
        @IBOutlet weak var areaLabel: UILabel!
        var listVC = FourthViewController()
        
        static var identifier: String {
            return "CountriesCollectionViewCell"
        }
        
        
        func config(countryname: String, capital: String, region: String, subRegion: String, population: String, area: Float, language: String, flagUrl: String, latitude: String, longitude: String, currrency: String, currrencySymbol: String){
            
//            mainView.backgroundColor = .myBeige
//            mainView.layer.cornerRadius = mainView.bounds.height * 0.05
            
            countrynameLabel.text = "Country: \(countryname)"
            capitalLabel.text = "Capital: \(capital)"
            regionLabel.text = "Region: \(region)"
            languageLabel.text = "Language: \(language)"
            currencyLabel.text = "Currency: \(currrency) (\(currrencySymbol))"
            populationLabel.text = "Population: \(formatNumber(bigNumber: population))"
            subregionLabel.text = "Sub Region: \(subRegion)"
            areaLabel.text = "Area(km²): \(formatArea(bigNumber: area))"
            var flag = flagUrl
            flag = flag.replacingOccurrences(of: ".", with: "")
            imageView.image = UIImage(named: "\(flag).png") ?? UIImage(named: "globe_white.png")
            
    //        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
    //        imageView.addGestureRecognizer(pictureTap)
            
        }
        
        
    //    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
    //        let imageView = sender.view as! UIImageView
    //        let newImageView = UIImageView(image: imageView.image)
    //        newImageView.frame = UIScreen.main.bounds
    //        newImageView.backgroundColor = .black
    //        newImageView.contentMode = .scaleAspectFit
    //        newImageView.isUserInteractionEnabled = true
    //        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
    //        newImageView.addGestureRecognizer(tap)
    //        self.mainView.addSubview(newImageView)
    //    }
    //
    //    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
    //        sender.view?.removeFromSuperview()
    //    }
        
    

}
