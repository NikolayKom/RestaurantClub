//
//   Created by Nikolay on 09.05.2021.
//

import UIKit

extension UIImageView {
	
	func loadImage(urlString: String)  {
		if let image = ImageStorage.shared.get(key: urlString) {
			self.image = image
			return
		}
		
		guard let url = URL(string: urlString) else { return }
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
				ImageStorage.shared.save(key: urlString, imageData: data)
				DispatchQueue.main.async { self?.image = image }
			}
		}
	}
}
