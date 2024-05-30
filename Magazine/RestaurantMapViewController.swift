//
//  RestaurantMapViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var mapView: MKMapView!
    
    var list = RestaurantList().restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        allAnnotation()

    }
    func configureMapView() {
        let location = CLLocationCoordinate2D(latitude: 37.518017, longitude: 126.886696)
        mapView.region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
    }
    
    func setAnnotation(data: Restaurant) {
        let location = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = data.name
        mapView.addAnnotation(annotation)
    }
    
    func allAnnotation() {
        for restaurant in list {
            setAnnotation(data: restaurant)
        }
    }

}
