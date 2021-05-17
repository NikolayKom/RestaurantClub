//
//  TableViewMain.swift
//  RestoranClub
//
//  Created by Николай on 17.05.2021.
//  Copyright © 2021 Kreative Developer. All rights reserved.
//

import UIKit

class TableViewMain: UITableViewCell {

    @IBOutlet var descriptionRestoranLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: Restorant) {
        
        descriptionRestoranLabel.text = "ты дебил"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
