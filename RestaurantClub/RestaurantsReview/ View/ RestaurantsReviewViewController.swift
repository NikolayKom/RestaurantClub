//
//  ResaurantsReviewViewController.swift
//  RestaurantClub
//
//  Created by Николай on 23.05.2021.
//

import UIKit
import Cosmos
import TinyConstraints

final class RestaurantsReviewViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet weak var sendReviewButton: UIButton!
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        view.settings.starSize = 35
        return view
    }()
    
    var numberOfRestoran = String()
    var name = ""
    var text = ""

    lazy var reviewPresenter = RestaurantsReviewPresenter(viewController: self)
    
    @IBAction func sendReview(_ sender: Any) {
        text = reviewTextField.text
        name = nameTextField.text ?? "Username"
        reviewPresenter.sendReview(NumberOfRestoran: "\(numberOfRestoran)", textReview: text, userName: name, stars: Int(self.cosmosView.rating))
        showThanks(title: "Отзыв отправлен", message: "Спасибо за оценку")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUISettings()
        swipeDown()
    }
    
    func setupUISettings() {
        self.view.addSubview(cosmosView)
        cosmosView.top(to: self.reviewTextField, offset: -50)
        cosmosView.right(to: self.view, offset: -23)
        self.reviewTextField.layer.cornerRadius = 10
    }
    
    func showThanks(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(.init(title: "Ок", style: .cancel, handler: self.hideReview))
        present(alert, animated: true, completion: nil)
    }
    
    func hideReview(_ alertAction: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func swipeDown() {
        let swipeDown =  UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeUp))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeDown)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension RestaurantsReviewViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
     }
    
    @objc func hideKeyboardOnSwipeUp() {
        view.endEditing(true)
        view.reloadInputViews()
     }
}
