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
   private let feedBackMediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    
   private var locationManager = CLLocationManager()
   private var userLocationCoordinate: CLLocationCoordinate2D!
    
// MARK: - Outlets
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Actions
    @IBAction private func locationButtonClicked(_ sender: Any) {
        self.setDeviceLocationAnnotation()
    }
    
    @IBAction private func sendReqestButtonClicked(_ sender: Any) {
        // TODO: исправить анотации
        if !self.mapView.annotations.isEmpty {
            self.showInfo(message: R.string.towTruck.requestSend())
        } else {
            self.showInfo(message: R.string.towTruck.choosePickUpPoint())
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
    
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerLongTapGesture()
        self.locationManagerSettings()
        self.setupUISettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locationManager.stopUpdatingLocation()
        
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
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func showInfo(message: String ) {
        let alert = UIAlertController(
            title: R.string.alerts.evacuationService(),
            message: message,
            preferredStyle: .alert
            )
            
        alert.addAction(.init(title: R.string.alerts.ok(), style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
    
    private func setDeviceLocationAnnotation() {
        guard let locations = self.userLocationCoordinate else { return }
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        self.locationManager.startUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.userLocationCoordinate
        annotation.title = R.string.towTruck.currectLocation()
        
        self.mapView.addAnnotation(annotation)
        self.feedBackMediumGenerator.impactOccurred()
        self.locationManager.stopUpdatingLocation()
    }
    
    private func setupUISettings() {
        self.mapView.delegate = self
    }
    
    private func registerLongTapGesture() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.createNewAnnotation))
        longTap.minimumPressDuration = 0.15
        self.mapView.addGestureRecognizer(longTap)
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
            self.feedBackMediumGenerator.impactOccurred()
        }
        sender.state = .cancelled
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
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
