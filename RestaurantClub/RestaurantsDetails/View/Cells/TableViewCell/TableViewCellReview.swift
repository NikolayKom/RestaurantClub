//
//  TableViewCellReview.swift
//  RestoranClub
//
//  Created by Николай on 17.05.2021.

import UIKit

class TableViewCellReview: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var restaurantsReview: [Review]?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
			UINib.init(nibName: "CollectionViewCell", bundle: nil),
			forCellWithReuseIdentifier: "collectionViewID")
    }
	
	func configure() {
        collectionView.reloadData()
	}
}

extension TableViewCellReview: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(
		_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantsReview?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "collectionViewID",
			for: indexPath as IndexPath
		) as! CollectionViewCell
        
        if let restaurants = restaurantsReview?[indexPath.item] {
            cell.configure(model: restaurants)
           
        }
        
        return cell
            
	}
}

extension TableViewCellReview: UICollectionViewDelegateFlowLayout {
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		bounds.size
	}
}
