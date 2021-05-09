//
//   Created by Statnikov Eugene on 09.05.2021.
//   Copyright (c) 2021 SEA. All rights reserved.
//

import UIKit

extension UIImageView {
	
	func loadImage(urlString: String)  {
		guard let url = URL(string: urlString) else { return }
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			//print(urlString)
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
