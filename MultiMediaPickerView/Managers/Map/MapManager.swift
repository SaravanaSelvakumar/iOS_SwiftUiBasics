//
//  File.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 15/07/24.
//

import Foundation
import CoreLocation
import MapKit

class MapManager: NSObject {
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var mapView: MKMapView?
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - Public Methods
    
    func getCurrentLocation(completion: @escaping (CLLocation?) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            if let location = locationManager.location {
                currentLocation = location
                completion(location)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
    func chooseLocationAndFetchCoordinates(for address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                completion(placemark.location?.coordinate)
            } else {
                completion(nil)
            }
        }
    }
    
    func showRouteOnMap(from startCoordinate: CLLocationCoordinate2D, to endCoordinate: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: startCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: endCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile // You can change the transport type as needed
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let route = response?.routes.first else {
                if let error = error {
                    print("Error calculating route: \(error.localizedDescription)")
                }
                return
            }
            
            // Add the route polyline to the map
            self.mapView?.addOverlay(route.polyline, level: .aboveRoads)
            
            // Optionally, zoom the map to show the route
            let rect = route.polyline.boundingMapRect
            self.mapView?.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    // MARK: - Helper Methods
    
    func setMapView(_ mapView: MKMapView) {
        self.mapView = mapView
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MapManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        // Optionally, stop updating location once found
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
}

// MARK: - MKMapViewDelegate

extension MapManager: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
}
