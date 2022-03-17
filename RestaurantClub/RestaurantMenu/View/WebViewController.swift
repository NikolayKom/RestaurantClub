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
    
// MARK: - Actions
    @IBAction private func closeButtonPressed(_ sender: Any) {
        guard let topMostController = UIWindow.sqTopMostViewController else { return }

        topMostController.dismiss(animated: true)
    }
    
// MARK: - MVP
    lazy var webPresenter = WebPresenter(viewController: self)
    
// MARK: - Params
    internal var restaurantMenu = String()
    
// MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        self.openRestaurantMenu()
    }
    
// MARK: - Private Methods
    private func openRestaurantMenu() {
        self.startAnimating()
        
        self.webView.navigationDelegate = self
        self.webView.load(self.webPresenter.createRequest(
            restaurantMenu: self.restaurantMenu)
        )
    }
    
    private func startAnimating() {
        self.activityIndicator.startAnimating()
    }
    
    private func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
}

// MARK: - WKNavigationDelegate
extension WebViewCotroller: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        self.stopAnimating()
      }
}
