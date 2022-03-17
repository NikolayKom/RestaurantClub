//
//  ResaurantsReviewViewController.swift
//  RestaurantClub
//
//  Created by Николай on 23.05.2021.
//

import UIKit
import Cosmos

final class RestaurantsReviewViewController: UIViewController {

// MARK: - Outlet
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var reviewTextField: UITextView!
    @IBOutlet private weak var sendReviewButton: UIButton!
    @IBOutlet private weak var starsView: CosmosView!
    
    private var name = String()
    private var text = String()
    
    internal var numberOfRestoran = String()

// MARK: - MVP
    lazy var reviewPresenter = RestaurantsReviewPresenter(viewController: self)

// MARK: - Action
    @IBAction private func sendReview(_ sender: Any) {
        guard !self.reviewTextField.text.isEmpty && !(self.nameTextField.text?.isEmpty ?? false) && !(starsView.rating == Double(0)) else
        { return self.showAlert(title: R.string.alerts.error(),                                                     message: R.string.alerts.needData(),
                                error: true
        )}
        
        self.text = reviewTextField.text
        self.name = nameTextField.text ?? R.string.restaurantsReview.username()
        self.reviewPresenter.sendReview(NumberOfRestoran: "\(numberOfRestoran)",
                                        textReview: text,
                                        userName: name,
                                        stars: Int(self.starsView.rating)
        )
        
        self.showAlert(title: R.string.alerts.reviewSend(),
                       message: R.string.alerts.thanksForReview(),
                       error: false
        )
        
        UIDevice.addFeedback(style: .carPointChoosed)
    }
    
    @IBAction private func closeButtonPressed(_ sender: Any) {
        guard let topMostController = UIWindow.sqTopMostViewController else { return }

        topMostController.dismiss(animated: true)
    }
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swipeDown()
    }

// MARK: - Private Methods
    private func showAlert(title: String, message: String, error: Bool) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(.init(title: R.string.alerts.ok(),
                              style: .cancel,
                              handler: error ? nil : self.hideReview
                             )
        )
        present(alert, animated: true, completion: nil)
    }
    
    private func hideReview(_ alertAction: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func swipeDown() {
        let swipeDown =  UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeUp))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeDown)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension RestaurantsReviewViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
     }
    
    @objc func hideKeyboardOnSwipeUp() {
        self.view.endEditing(true)
        self.view.reloadInputViews()
     }
}
