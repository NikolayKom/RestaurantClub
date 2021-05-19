//
//  TableViewCellReview.swift
//  RestoranClub
//
//  Created by Николай on 17.05.2021.
//  Copyright © 2021 Kreative Developer. All rights reserved.
//

import UIKit

class TableViewCellReview: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(model: Restorant) {
        
        userNameLabel.text = "3"
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
