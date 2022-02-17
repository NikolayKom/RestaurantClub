//
//  OpenMapDirections.swift
//  RestaurantClub
//
//  Created by Николай on 15.02.2022.
//

import CoreLocation
import MapKit
import UIKit

final class OpenMapDirections {
    // If you are calling the coordinate from a Model, don't forgot to pass it in the function parenthesis.
    static func present(in viewController: UIViewController,
                        sourceView: UIView,
                        serviceName: String,
                        latitude: CLLocationDegrees,
                        langitude: CLLocationDegrees ) {
        
        let actionSheet = UIAlertController(title: "Проложить маршрут",
                                            message: "Выберите приложение:",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Google Maps",
                                            style: .default,
                                            handler: { _ in
            let url = URL(string: "comgooglemaps://?daddr=\(latitude),\(langitude)&directionsmode=driving&zoom=14&views=traffic")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Apple Maps",
                                            style: .default,
                                            handler: { _ in
            
            let coordinate = CLLocationCoordinate2DMake(latitude, langitude)
            
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate,
                                                           addressDictionary: nil))
            mapItem.name = "\(serviceName)"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }))
        
        actionSheet.popoverPresentationController?.sourceRect = sourceView.bounds
        actionSheet.popoverPresentationController?.sourceView = sourceView
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
