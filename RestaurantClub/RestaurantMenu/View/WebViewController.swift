//
//  WebViewController.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import WebKit
import UIKit

final class WebViewCotroller: UIViewController {
    
// MARK: - Outlet
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - MVP
    lazy var webPresenter = WebPresenter(viewController: self)
    
// MARK: - Params
    var restaurantMenu = String()
    
// MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        self.openRestaurantMenu()
    }
    
// MARK: - Private Methods
    private func openRestaurantMenu() {
        self.startAnimating()
        var myURL: URL!
        myURL = URL(string: "\(self.restaurantMenu)")
        let myRequest = URLRequest(url: myURL!)
        self.stopAnimating()
        webView.load(myRequest)
    }
    
    private func startAnimating() {
        self.activityIndicator.startAnimating()
    }
    
    private func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
}
