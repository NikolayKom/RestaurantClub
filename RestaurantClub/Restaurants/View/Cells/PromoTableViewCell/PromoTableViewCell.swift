//
//  PromoCollectionViewCell.swift
//  RestaurantClub
//
//  Created by Николай on 15.03.2022.
//

import Foundation
import UIKit

protocol OpenByCellClicked {
    
    func didCellClicked(promoSto: Int)
}

final class PromoTableViewCell: UITableViewCell, UICollectionViewDataSource {
    
// MARK: - Outlet
    @IBOutlet private weak var promoCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.promoCollectionView.dataSource = self
        self.promoCollectionView.delegate = self
        self.promoCollectionView.register(
            UINib.init(nibName: "PromoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "promoCollectionViewID")
    }
    
// MARK: - Perm
    var delegate: OpenByCellClicked?
    private var promo = FakePromo.allFakePromo
    
    
//MARK: - Public method
    func configure() {
        self.promoCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PromoTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 225, height: 90)
    }
}

// MARK: - UICollectionViewDelegate
extension PromoTableViewCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return promo.count
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "promoCollectionViewID",
            for: indexPath as IndexPath
        ) as! PromoCollectionViewCell
        
        cell.configure(model: FakePromo.allFakePromo[indexPath.row])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            self.didCellClicked(promoSto: FakePromo.allFakePromo[indexPath.row].restaurantId)
        }
}

// MARK: - OpenByCellClicked
extension PromoTableViewCell: OpenByCellClicked {
    func didCellClicked(promoSto: Int) {
        self.delegate?.didCellClicked(promoSto: promoSto)
    }
}

