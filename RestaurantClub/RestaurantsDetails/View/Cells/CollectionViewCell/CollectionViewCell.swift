//
//  CollectionViewCell.swift
//  RestoranClub
//
//  Created by Николай on 21.05.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameUserLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    func configure(model: Review) {
        
        nameUserLabel.text = model.user_name
      
        }
    }

