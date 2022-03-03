//
//  TableViewMain.swift
//  RestoranClub
//
//  Created by Николай on 17.05.2021.
//

import UIKit

final class TableViewMain: UITableViewCell {

// MARK: - Outlet
    @IBOutlet private var descriptionRestoranLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: FakeRestorant) {
        self.descriptionRestoranLabel.text = model.aboutRestaurant
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
