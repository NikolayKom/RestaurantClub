//
//  TableViewCellServices.swift
//  RestaurantClub
//
//  Created by Николай on 05.03.2022.
//

import UIKit

protocol CostOfServiceByButton {
    func didAddItemButtonPressed(id: Int, costForService: Int)
    func didAddItemButtonDeSelected(id: Int, costForService: Int)
}

final class TableViewCellServices: UITableViewCell {

    var delegate: CostOfServiceByButton?
    
// MARK: - Outlet
    @IBOutlet private weak var serviceNameLabel: UILabel!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet private weak var costOfServiceLabel: UILabel!
    
// MARK: - Action
    @IBAction private func addItemButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.delegate?.didAddItemButtonDeSelected(id: self.id,
                                                      costForService: self.costOfService
            )
        } else {
            sender.isSelected = true
            self.delegate?.didAddItemButtonPressed(id: self.id,
                                                   costForService: self.costOfService
            )
        }
        
        UIDevice.addFeedback(style: .buttonClicked)
    }
    
// MARK: - Perm
    private var id = Int()
    private var costOfService = Int()
    private var itemInCard = Bool()
    
// MARK: - Configure
    func configure(model: FakeService) {
        self.setupUI(model: model)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI(model: FakeService) {
        self.serviceNameLabel.text = model.serviceName
        self.costOfServiceLabel.text = "\(model.serviceCost) ₽"
        self.costOfService = model.serviceCost
        self.id = model.id
        if model.itemInCard {
            self.addItemButton.isSelected = true
        } else {
            self.addItemButton.isSelected = false
        }
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
}
