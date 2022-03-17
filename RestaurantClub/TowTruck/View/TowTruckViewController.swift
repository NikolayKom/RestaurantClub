//
//  TowTruckCallViewController.swift
//  RestaurantClub
//
//  Created by Николай on 07.02.2022.
//

import Foundation
import MapKit
import CoreLocation

final class TowTruckViewController: UIViewController {
    
// MARK: - MVP
   lazy var towTruckPresenter = TowTruckPresenter(viewController: self)

// MARK: - Perm
   private var locationManager = CLLocationManager()
   private var userLocationCoordinate: CLLocationCoordinate2D!
    
// MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var addressView: UIView!
    @IBOutlet private weak var requestView: UIView!
    @IBOutlet private weak var hideKeyboardButton: UIButton!
    @IBOutlet private weak var addressTextField: UITextField!
    
    // MARK: - Actions
    @IBAction private func locationButtonClicked(_ sender: Any) {
        self.setDeviceLocationAnnotation()
    }
    
    @IBAction private func sendReqestButtonClicked(_ sender: Any) {
        if !(self.addressTextField.text?.isEmpty ?? true) {
            self.showInfo(message: R.string.towTruck.requestSend(), error: false)
            UIDevice.addFeedback(style: .buttonClicked)
        } else {
            self.showInfo(message: R.string.towTruck.choosePickUpPoint(), error: true)
            UIDevice.addFeedback(style: .error)
        }
    }
    
    @IBAction private func closeButtonClicked(_ sender: Any) {
        guard let topMostController = UIWindow.sqTopMostViewController else { return }

        topMostController.dismiss(animated: true)
    }
    
    @IBAction private func callButtonClicked(_ sender: Any) {
        // TODO: взять из данных сто
        self.callNumber(phoneNumber: "+79137983597")
    }
    
    @IBAction private func hideKeyboardButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.hideKeyboardButton.isHidden = true
    }
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerLongTapGesture()
        self.registerTextFieldTarget()
        self.locationManagerSettings()
        self.setupUISettings()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locationManager.stopUpdatingLocation()
        self.observersSetup()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setDeviceLocationAnnotation()
        }
    }
    
// MARK: - Private methods
    private func locationManagerSettings() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    }
    
    private func registerTextFieldTarget() {
        self.addressTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func showInfo(message: String, error: Bool) {
        let alert = UIAlertController(
            title: R.string.alerts.evacuationService(),
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
        guard let topMostController = UIWindow.sqTopMostViewController else { return }
        
        topMostController.dismiss(animated: true)
    }
    
    private func setDeviceLocationAnnotation() {
        guard self.userLocationCoordinate != nil else { return }
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        self.locationManager.startUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.userLocationCoordinate
        annotation.title = R.string.towTruck.currectLocation()
        
        self.mapView.addAnnotation(annotation)
        self.locationManager.stopUpdatingLocation()
        self.addressTextField.text = R.string.towTruck.currectLocation()
        
        UIDevice.addFeedback(style: .carPointChoosed)
    }
    
    private func setupUISettings() {
        self.mapView.delegate = self
        self.addressView.layer.masksToBounds = true
        // TODO: запихать в colors нужный цвет
        self.addressView.layer.borderColor = R.color.textGray()?.cgColor
        self.addressView.layer.borderWidth = 1.0
        self.hideKeyboardButton.isHidden = true
    }
    
    private func registerLongTapGesture() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.createNewAnnotation))
        longTap.minimumPressDuration = 0.15
        self.mapView.addGestureRecognizer(longTap)
    }
    
    private func observersSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func createNewAnnotation(_ sender: UIGestureRecognizer) {
        let touchPoint = sender.location(in: self.mapView)
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let heldPoint = MKPointAnnotation()
        heldPoint.coordinate = coordinates
        if (sender.state == .began) {
            heldPoint.title = R.string.towTruck.choosePickUpPoint()
            heldPoint.subtitle = String(format: "%.4f", coordinates.latitude) + "," + String(format: "%.4f", coordinates.longitude)
            self.mapView.addAnnotation(heldPoint)
            self.addressTextField.text = R.string.towTruck.choosedLocation()
            
            UIDevice.addFeedback(style: .carPointChoosed)
        }
        sender.state = .cancelled
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y = -keyboardSize.height
                self.hideKeyboardButton.isHidden = false
        }
    }
    
    @objc private func editingBegan(_ textField: UITextField) {
        self.addressTextField.text = nil
    }
}

//MARK: - MKMapViewDelegate
extension TowTruckViewController: MKMapViewDelegate {
    
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return MKAnnotationView() }
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        annotationView.image = UIImage(named: R.string.towTruck.pin())
        annotationView.canShowCallout = true
        return annotationView
    }
}

//MARK: - CLLocationManagerDelegate
extension TowTruckViewController: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        let userLocation: CLLocation = locations[0] as CLLocation
        self.userLocationCoordinate = manager.location!.coordinate
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                            longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                               longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.addressTextField.text = R.string.towTruck.currectLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
