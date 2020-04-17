//
//  FourthViewController.swift
//  CountryAndFlagQuiz
//
//  Created by Henrik on 2020-03-29.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
        
        @IBOutlet weak var countryCV: UICollectionView!
        var getFlags = GetFlags()
        var list = [Country]()
        var searchList = [Country]()
        var searching = false
        var flagImage = ""
//        @IBOutlet weak var mainButton: UIButton!
        @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet var flagView: UIView!
        @IBOutlet weak var bigFlag: UIImageView!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            config()
            
            self.title = "List"
        }
        
        @IBAction func mainButton(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        
        func config() {
            let aSelector : Selector = #selector(FourthViewController.removeViewFromSuperView)
            let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
            flagView.addGestureRecognizer(tapGesture)
            flagView.translatesAutoresizingMaskIntoConstraints = true
            searchBar.delegate = self
            countryCV.backgroundColor = .myWhite2
            list = getFlags.readJSONFromFile()
            self.countryCV.dataSource = self
            self.countryCV.delegate = self
            self.countryCV.register(UINib.init(nibName: CountriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CountriesCollectionViewCell.identifier)
//            mainButton.layer.cornerRadius = mainButton.bounds.height / 2
//            mainButton.backgroundColor = .myBlue
            self.countryCV.keyboardDismissMode = .onDrag
        }
        
        func showFlagView(flag: String){
            view.addSubview(flagView)
            let flagFormat = flag.replacingOccurrences(of: ".", with: "")
            let image = UIImage(named: "\(flagFormat).png")
            bigFlag.image = image?.rotate(radians: .pi/2)
            
            flagView.isUserInteractionEnabled = true
            animate()
        }
        
        @objc func removeViewFromSuperView() {
            if let subView = self.flagView{
                subView.removeFromSuperview()
                print("tar bort")
            } else {
                print("ikke!!")
                return
            }
        }
        
        func animate() {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                self.flagView.alpha = 1
                self.flagView.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
                self.flagView.layer.cornerRadius = 20
                self.flagView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            }) { _ in
            }
        }
        
        
    }

    extension FourthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if searching {
                return searchList.count
            }else {
                return list.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            showFlagView(flag: list[indexPath.row].flagUrl)
            
        }
        

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: screenWidth * 0.54, height: screenHeight * 0.74)
            }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = countryCV.dequeueReusableCell(withReuseIdentifier: CountriesCollectionViewCell.identifier, for: indexPath) as! CountriesCollectionViewCell
            var country = list[indexPath.row]
            if searching {
                country = searchList[indexPath.row]
            } else {
                country = list[indexPath.row]
            }
            flagImage = list[indexPath.row].flagUrl
            cell.config(countryname: country.name, capital: country.capital, region: country.region, subRegion: country.subregion, population: country.population, area: country.area, language: country.language, flagUrl: country.flagUrl, latitude: country.latitude, longitude: country.longitude, currrency: country.currency, currrencySymbol: country.currencySymbol)
            
            return cell
        }
    }

    extension FourthViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchList = list.filter({ country -> Bool in
                if searchText.isEmpty { return true }
                searching = true
                return country.name.lowercased().hasPrefix(searchText.lowercased())
            })
            countryCV.reloadData()
            print(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchBar.text = ""
            countryCV.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
        {
            searching = false
            self.searchBar.endEditing(true)
        }
        
    }

    extension UIImage {
        func rotate(radians: Float) -> UIImage? {
            var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
            // Trim off the extremely small float value to prevent core graphics from rounding it up
            newSize.width = floor(newSize.width)
            newSize.height = floor(newSize.height)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
            let context = UIGraphicsGetCurrentContext()!
            
            // Move origin to middle
            context.translateBy(x: newSize.width/2, y: newSize.height/2)
            // Rotate around middle
            context.rotate(by: CGFloat(radians))
            // Draw the image at its center
            self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }

}
