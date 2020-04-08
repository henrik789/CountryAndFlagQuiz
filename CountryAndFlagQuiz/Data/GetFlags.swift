
import Foundation

class GetFlags {
    
    var pictures = [String]()
    var totalFlags = [String]()
    var countryList = [Country]()
    
    func buildArray() {
        let docPath = Bundle.main.resourcePath! + "/" + "Countries"
        let fileManager = FileManager.default
        let filesFromBundle = try! fileManager.contentsOfDirectory(atPath: docPath)
        pictures = filesFromBundle
        totalFlags = filesFromBundle
    }
    
    
    func buildFlagArray() -> String {
        if pictures.count < 2 {
            let fileName = pictures[0]
            var components = fileName.components(separatedBy: ".")
            print("Last one is \(pictures[0])")
            if components.count > 1 { // If there is a file extension
                components.removeLast()
                return components.joined(separator: ".")
            }
        }else {
            let randomNumber = Int.random(in: 0..<pictures.count)
            let randomFlag = pictures[randomNumber]
            let fileName = randomFlag
            pictures.remove(at: randomNumber)
            //                print(pictures.count)
            var components = fileName.components(separatedBy: ".")
            if components.count > 1 { // If there is a file extension
                components.removeLast()
                return components.joined(separator: ".")
            }
        }
        return "Sweden"
    }

    func buildImageArray() -> [String] {
        
        let docPath = Bundle.main.resourcePath! + "/" + "Countries"
        let fileManager = FileManager.default
        let filesFromBundle = try! fileManager.contentsOfDirectory(atPath: docPath)
        pictures = filesFromBundle
        var images = [String]()
        for image in pictures {
            images.append(checkCountry(landCode: image))
        }
        
        return images
        
    }
    
    func buildFlagArray1(number: Int) -> String {

        //            let randomNumber = Int.random(in: 0..<totalFlags.count )
        let randomFlag = totalFlags[number]
        let fileName = randomFlag

        var components = fileName.components(separatedBy: ".")
        if components.count > 1 { // If there is a file extension
            components.removeLast()
            //                print("1: \(components.joined(separator: "."))")
            return components.joined(separator: ".")
        }

        return fileName

    }

    
    func readJSONFromFile() -> [Country] {
        if let path = Bundle.main.path(forResource: "countriesDict", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                //                    json = try? JSONSerialization.jsonObject(with: data)
                let json = try JSON(data: data)
                let personList = json[].map { (_, personJSON) in
                    return Country(json: personJSON)
                }
                countryList = personList
                
            } catch {
                // Handle error here
            }
        }
        return countryList
    }
    
    
    func checkCountry(landCode: String) -> String {
        switch landCode {
        case "ad":
            return "Andorra"
        case "af":
            return "Afghanistan"
        case "ag":
            return "Antigua and Barbuda"
        case "al":
            return "Albania"
        case "ao":
            return "Angola"
        case "bs":
            return "Bahamas"
        case "dz":
            return "Algeria"
        case "am":
            return "Armenia"
        case "ar":
            return "Argentina"
        case "at":
            return "Austria"
        case "au":
            return "Australia"
        case "az":
            return "Azerbaijan"
        case "ba":
            return "Bosnia and Herzegovina"
        case "bb":
            return "Barbados"
        case "bd":
            return "Bangladesh"
        case "be":
            return "Belgium"
        case "bf":
            return "Burkina Faso"
        case "bg":
            return "Bulgaria"
        case "bh":
            return "Bahrain"
        case "bi":
            return "Burundi"
        case "bj":
            return "Benin"
        case "bn":
            return "Brunei"
        case "bo":
            return "Bolivia"
        case "br":
            return "Brazil"
        case "bt":
            return "Bhutan"
        case "bw":
            return "Botswana"
        case "by":
            return "Belarus"
        case "bz":
            return "Belize"
        case "ca":
            return "Canada"
        case "cf":
            return "The Central African Republic"
        case "cl":
            return "Chile"
        case "cm":
            return "Cameroon"
        case "cv":
            return "Cape Verde"
        case "kh":
            return "Cambodia"
        case "td":
            return "Chad"
        case "hu":
            return "Hungary"
        case "hn":
            return "Honduras"
        case "ht":
            return "Haiti"
        case "gy":
            return "Guyana"
        case "gw":
            return "Guinea Bissau"
        case "gn":
            return "Guinea"
        case "gt":
            return "Guatemala"
        case "gd":
            return "Grenada"
        case "gr":
            return "Greece"
        case "gh":
            return "Ghana"
        case "de":
            return "Germany"
        case "ge":
            return "Georgia"
        case "gm":
            return "Gambia"
        case "ga":
            return "Gabon"
        case "fr":
            return "France"
        case "fi":
            return "Finland"
        case "fj":
            return "Fiji"
        case "et":
            return "Ethiopia"
        case "ee":
            return "Estonia"
        case "er":
            return "Eritrea"
        case "gq":
            return "Equatorial Guinea"
        case "sv":
            return "El Salvador"
        case "eg":
            return "Egypt"
        case "ec":
            return "Ecuador"
        case "tl":
            return "East Timor"
        case "do":
            return "The Dominican Republic"
        case "dm":
            return "Dominica"
        case "dj":
            return "Djibouti"
        case "dk":
            return "Denmark"
        case "cd":
            return "The Democratic Republic of Congo"
        case "cz":
            return "The Czech Republic"
        case "cy":
            return "Cyprus"
        case "cu":
            return "Cuba"
        case "hr":
            return "Croatia"
        case "ci":
            return "Cote d'Ivorie"
        case "cr":
            return "Costa Rica"
        case "ck":
            return "Cook Islands"
        case "km":
            return "The Comoros"
        case "co":
            return "Colombia" //kjhgg//
        case "is":
            return "Iceland"
        case "in":
            return "India"
        case "id":
            return "Indonesia"
        case "ir":
            return "Iran"
        case "iq":
            return "Iraq"
        case "ie":
            return "Ireland"
        case "il":
            return "Israel"
        case "it":
            return "Italy"
        case "jm":
            return "Jamaica"
        case "jp":
            return "Japan"
        case "jo":
            return "Jordan"
        case "kz":
            return "Kazahkstan"
        case "ke":
            return "Kenya"
        case "ki":
            return "Kiribati"
        case "xk":
            return "Kosovo"
        case "kw":
            return "Kuwait"
        case "kg":
            return "Kyrgyztan"
        case "la":
            return "Laos"
        case "lv":
            return "Latvia"
        case "lb":
            return "Lebanon"
        case "ls":
            return "Lesotho"
        case "lr":
            return "Liberia"
        case "ly":
            return "Libya"
        case "li":
            return "Liechtenstein"
        case "lt":
            return "Lithuania"
        case "lu":
            return "Luxembourg"
        case "mk":
            return "Macedonia"
        case "mg":
            return "Madagascar"
        case "mw":
            return "Malawi"
        case "my":
            return "Malaysia"
        case "mv":
            return "Maldives"
        case "ml":
            return "Mali"
        case "mt":
            return "Malta"
        case "mh":
            return "The marshall Islands"
        case "mr":
            return "Mauretania"
        case "mu":
            return "Mauritius"
        case "mx":
            return "Mexico"
        case "fm":
            return "Micronesia"
        case "md":
            return "Moldova"
        case "mc":
            return "Monaco"
        case "mn":
            return "Mongolia"
        case "me":
            return "Montenegro"
        case "ma":
            return "Morocco"
        case "mz":
            return "Mozambique"
        case "mm":
            return "Myanmar"
        case "na":
            return "Namibia"
        case "nr":
            return "Nauru"
        case "np":
            return "Nepal"
        case "nl":
            return "The Netherlands"
        case "nz":
            return "New Zeeland"
        case "ni":
            return "Nicaragua"
        case "ne":
            return "Niger"
        case "ng":
            return "Nigeria"
        case "nu":
            return "Niue"
        case "kp":
            return "North Korea"
        case "no":
            return "Norway"
        case "om":
            return "Oman"
        case "pk":
            return "Pakistan"
        case "pw":
            return "Palau"
        case "pa":
            return "Panama"
        case "pg":
            return "Papua New Guinea"
        case "py":
            return "Paraguay"
        case "cn":
            return "The Peoples Republic of China"
        case "pe":
            return "Peru"
        case "ph":
            return "The Philippines"
        case "pl":
            return "Poland"
        case "pt":
            return "Portugal"
        case "qa":
            return "Qatar"
        case "tw":
            return "The Republic of China"
        case "cg":
            return "The Republic of the Congo"
        case "ro":
            return "Romania"
        case "ru":
            return "Russia"
        case "rw":
            return "Rwanda"
        case "kn":
            return "Saint Kitts and Nevis"
        case "lc":
            return "Saint Lucia"
        case "vc":
            return "Saint Vincent and the Grenadines"
        case "ws":
            return "Samoa"
        case "sm":
            return "San Marino"
        case "st":
            return "Sao Tome and Principe"
        case "sa":
            return "Saudi Arabia"
        case "sn":
            return "Senegal"
        case "rs":
            return "Serbia"
        case "sc":
            return "The Seychelles"
        case "sl":
            return "Sierra Leone"
        case "sg":
            return "Singapore"
        case "sk":
            return "Slovakia"
        case "si":
            return "Slovenia"
        case "sb":
            return "The Solomon Islands"
        case "so":
            return "Somalia"
        case "za":
            return "South Africa"
        case "kr":
            return "South Korea"
        case "ss":
            return "South Sudan"
        case "es":
            return "Spain"
        case "lk":
            return "Sri Lanka"
        case "ps":
            return "Palestine"
        case "sd":
            return "Sudan"
        case "sr":
            return "Suriname"
        case "sz":
            return "Swaziland"
        case "se":
            return "Sweden"
        case "ch":
            return "Switzerland"
        case "sy":
            return "Syria"
        case "tj":
            return "Tajikistan"
        case "tz":
            return "Tanzania"
        case "th":
            return "Thailand"
        case "tg":
            return "Togo"
        case "to":
            return "Tonga"
        case "tt":
            return "Trinidad and Tobago"
        case "tn":
            return "Tunisia"
        case "tr":
            return "Turkey"
        case "tm":
            return "Turkmenistan"
        case "tv":
            return "Tuvalu"
        case "ug":
            return "Uganda"
        case "ua":
            return "Ukraine"
        case "ae":
            return "The United Arab Emirates"
        case "gb":
            return "The United Kingdom"
        case "us":
            return "The United States"
        case "uy":
            return "Uruguay"
        case "uz":
            return "Uzbekistan"
        case "vu":
            return "Vanuatu"
        case "va":
            return "The Vatican City"
        case "ve":
            return "Venezuela"
        case "vn":
            return "Vietnam"
        case "eh":
            return "Western Sahara"
        case "ye":
            return "Yemen"
        case "zm":
            return "Zambia"
        case "zw":
            return "Zimababwe"
            
        default:
            return "Sweden"
        }
    }
    
    
}
