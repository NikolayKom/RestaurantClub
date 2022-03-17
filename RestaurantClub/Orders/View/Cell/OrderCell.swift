//
//  OrdersViewCell.swift
//  RestaurantClub
//
//  Created by Николай on 11.03.2022.
//

import UIKit

class OrderCell: UITableViewCell {
    
// MARK: - Outlet
    @IBOutlet private weak var nameOfOrderLabel: UILabel!
    @IBOutlet private weak var statusOfOrderLabel: UILabel!
    
// MARK: - Configure
    func configure(model: FakeOrders) {
        self.nameOfOrderLabel.text = model.nameOfOrder
        self.statusOfOrderLabel.text = model.status
        self.selectionStyle = .none
        
        guard let statusCode = model.statusCode else { return self.statusOfOrderLabel.textColor = .systemOrange}
        
        statusCode ? (self.statusOfOrderLabel.textColor = .systemGreen) : (self.statusOfOrderLabel.textColor = .systemRed)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
