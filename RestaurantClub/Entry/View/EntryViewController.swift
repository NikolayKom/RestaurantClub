//
//  EntryViewController.swift
//  RestaurantClub
//
//  Created by Николай on 05.03.2022.
//

import UIKit

final class EntryViewController: UIViewController, UITableViewDelegate {
    
// MARK: - MVP
   lazy var entryPresenter = EntryPresenter(viewController: self)

// MARK: - Outlet
    @IBOutlet private weak var servicesPricesLabel: UILabel!
    @IBOutlet private weak var serviceTableView: UITableView!
    @IBOutlet private weak var entryButton: GradientButton!
    
// MARK: - Action
    @IBAction private func entryButtonClicked(_ sender: Any) {
        self.showEntryReqest()
        UIDevice.addFeedback(style: .carPointChoosed)
    }
    
    @IBAction private func closeButtonClicked(_ sender: Any) {
        guard let topMostController = UIWindow.sqTopMostViewController else { return }

        topMostController.dismiss(animated: true)
    }
    
// MARK: - Perm
    private var costOfAllServices = Int()
    private let reuseIdentifier = "TableViewCellServices"
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.registerCell()
        self.disableEntryButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.entryPresenter.removeAllServices()
    }
    
// MARK: - Private methods
    private func registerCell() {
        self.serviceTableView.dataSource = self
        self.serviceTableView.delegate = self
        
        let entryCell = UINib(nibName: self.reuseIdentifier, bundle: nil)
        
        self.serviceTableView.register(entryCell,
                                       forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    private func setupUI() {
        self.servicesPricesLabel.text = nil
    }
    
    private func showEntryReqest() {
        let alert = UIAlertController(
            title: R.string.alerts.entry(),
            message: R.string.alerts.areYouSure("\(self.costOfAllServices)"),
            preferredStyle: .alert
            )
            
        alert.addAction(.init(title: R.string.alerts.agree(),
                              style: .cancel,
                              handler: { _ in
            
            guard let topMostController = UIWindow.sqTopMostViewController else { return }
            topMostController.dismiss(animated: true)
        }))
        
        alert.addAction(.init(title: R.string.alerts.cancel(),
                              style: .default))

        present(alert, animated: true, completion: nil)
    }
    
    private func reloadTableView() {
        self.serviceTableView.reloadData()
    }
    
    private func changeServicesPrices() {
        self.servicesPricesLabel.text = R.string.entry.costOfServices("\(self.costOfAllServices)")
    }
    
    private func disableEntryButton() {
        self.entryButton.setEnabled(false)
        self.entryButton.gradientColors = .grayGradient
    }
    
    private func enableEntryButton() {
        self.entryButton.setEnabled(true)
        self.entryButton.gradientColors = .purpleGradient
    }
}
 
// MARK: - UITableViewDataSource
extension EntryViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.entryPresenter.services.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier,  for: indexPath) as? TableViewCellServices
        else { return UITableViewCell() }
        
            let service = self.entryPresenter.services[indexPath.item]
            cell.configure(model: service)
            cell.delegate = self
            return cell
    }
}

extension EntryViewController: CostOfServiceByButton {
    
    func didAddItemButtonDeSelected(id: Int, costForService: Int) {
        self.costOfAllServices -= costForService
        self.costOfAllServices == .zero ?
        self.disableEntryButton() : self.enableEntryButton()
        self.changeServicesPrices()
        self.entryPresenter.removeService(id: id)
        self.reloadTableView()
    }
    
    
    func didAddItemButtonPressed(id: Int, costForService: Int) {
        self.costOfAllServices += costForService
        self.enableEntryButton()
        self.changeServicesPrices()
        self.entryPresenter.addService(id: id)
        self.reloadTableView()
    }
}
