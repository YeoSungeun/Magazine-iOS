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
        configureSegmentColtrol()
        allAnnotation()

    }
    
    @IBAction func segmentControlSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: allAnnotation()
        case 1: getKoreanFood()
        case 2: getWesternFood()
        case 3: getAsianFood()
        case 4: getEtcFood()
        default: break
        }
    }
    
    func configureMapView() {
        let location = CLLocationCoordinate2D(latitude: 37.518017, longitude: 126.886696)
        mapView.region = MKCoordinateRegion(center: location, latitudinalMeters: 800, longitudinalMeters: 800)
    }
    
    func configureSegmentColtrol() {
        segmentControl.removeAllSegments()
        
        segmentControl.insertSegment(withTitle: "전체", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "한식",at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "양식",at: 2, animated: true)
        segmentControl.insertSegment(withTitle: "아시안",at: 3, animated: true)
        segmentControl.insertSegment(withTitle: "기타", at: 4, animated: true)
        
        segmentControl.selectedSegmentIndex = 0
        
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
    
    func getKoreanFood() {
        mapView.removeAnnotations(mapView.annotations)
        for restaurant in list {
            if restaurant.category == "한식" {
                setAnnotation(data: restaurant)
            }
        }
    }
    func getWesternFood() {
        mapView.removeAnnotations(mapView.annotations)
        for restaurant in list {
            if restaurant.category == "양식" {
                setAnnotation(data: restaurant)
            }
        }
    }
    func getAsianFood() {
        mapView.removeAnnotations(mapView.annotations)
        for restaurant in list {
            if restaurant.category == "중식" || restaurant.category == "일식" {
                setAnnotation(data: restaurant)
            }
        }
    }
    func getEtcFood() {
        mapView.removeAnnotations(mapView.annotations)
        for restaurant in list {
            let category = restaurant.category
            if category != "한식", category != "양식", category != "일식", category != "중식" {
                setAnnotation(data: restaurant)
            }
        }
    }
}
