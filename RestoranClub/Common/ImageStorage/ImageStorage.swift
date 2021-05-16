//
//   Created by Statnikov Eugene on 16.05.2021.
//   Copyright (c) 2021 SEA. All rights reserved.
//

import UIKit

final class ImageStorage {
	
	// Почитай почему плох Singleton
	static let shared = ImageStorage()
	
	private var storage = [String: Data]()
	private let query = DispatchQueue(label: "savingImage")
	
	func save(key: String, imageData: Data) {
		guard storage[key] == nil else { return }
		query.async { [weak self] in
			self?.storage[key] = imageData
		}
	}
	
	func get(key: String) -> UIImage? {
		guard let data = storage[key] else { return nil }
		return UIImage(data: data)
	}
}


