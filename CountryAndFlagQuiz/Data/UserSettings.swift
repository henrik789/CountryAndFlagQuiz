
import Foundation

class UserSettings {
    var flagCount: Int
    var timeCount: Int
    
    class var sharedInstance:UserSettings {
        struct Singleton {
            static let instance = UserSettings()
        }
        return Singleton.instance
    }
    
    init() {
        flagCount = 30
        timeCount = 30
        
        let userDefaults = UserDefaults.standard
        flagCount = userDefaults.integer(forKey: "flagCount")
        timeCount = userDefaults.integer(forKey: "timeCount")
    }
    
    func saveGameStats() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(flagCount, forKey: "flagCount")
        userDefaults.set(timeCount, forKey: "timeCount")
        userDefaults.synchronize()
    }
}
