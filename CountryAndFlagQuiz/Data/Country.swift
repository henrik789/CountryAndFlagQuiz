import UIKit


struct Country {
    var name : String
    var capital : String
    var region : String
    var subregion : String
    var population : String
    var area : Float
    var language : String
    var flagUrl : String
    var latitude : String
    var longitude : String
    var currency : String
    var currencySymbol : String
    
    
//    func fullName () -> String {
//        return "\(self.firstName) \(self.lastName)"
//    }
//
//    func age () -> String {
//        let personAge = 2019 - yearOfBirth
//        return String(personAge)
//    }
    
}


extension Country {
    init(json: JSON) {
        let name = json["name"].stringValue
        let capital = json["capital"].stringValue
        let region = json["region"].stringValue
        let subregion = json["subregion"].stringValue
        let population = json["population"].stringValue
        let area = json["area"].floatValue
        let language = json["languages"][0]["name"].stringValue
        let flagUrl = json["topLevelDomain"][0].stringValue
        let latitude = json["latlng"][0].stringValue
        let longitude = json["latlng"][1].stringValue
        let currency = json["currencies"][0]["name"].stringValue
        let currencySymbol = json["currencies"][0]["symbol"].stringValue
        
        self = Country(name: name, capital: capital, region: region, subregion: subregion, population: population, area: area, language: language, flagUrl: flagUrl, latitude: latitude, longitude: longitude, currency: currency, currencySymbol: currencySymbol)
    }
}
