
import Foundation

class StorageController {
	private let userFileURL = FileManager.default
		.urls(for: .documentDirectory, in: .userDomainMask)
		.first!
		.appendingPathComponent("User")
		.appendingPathExtension("plist")
    static let shared = StorageController()
	
	init() {
		guard fetchUser() == nil else {
			return
		}
        let user = User(flagCount: 100, percentTimeQuiz: 1.0, pointsFlagQuiz: 1, timeCount: 30)
		save(user)
	}
	
	func fetchUser() -> User? {
		guard let data = try? Data(contentsOf: userFileURL) else {
			return nil
		}
		let decoder = PropertyListDecoder()
		return try? decoder.decode(User.self, from: data)
	}
	
	func save(_ user: User) {
		let encoder = PropertyListEncoder()
		if let data = try? encoder.encode(user) {
			try? data.write(to: userFileURL)
		}
	}
}
