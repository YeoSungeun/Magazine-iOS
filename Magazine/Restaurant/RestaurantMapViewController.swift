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
    
    @IBOutlet var filtertextField: UITextField!
    @IBOutlet var filterLabel: UILabel!
    
    var picker = UIPickerView()
    
    var list = RestaurantList().restaurantArray
    
    var filterOptionList = ["전체", "한식", "양식", "양식", "아시안", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        
        filtertextField.inputView = picker
        
        picker.delegate = self
        picker.dataSource = self
        
        configureMapView()
        configureSegmentColtrol()
        configurFilterLabel()
        
        allAnnotation()

    }
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentControlSelected(_ sender: UISegmentedControl) {
        getCategory(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func tappedView(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
    
    func getCategory(index: Int) {
        switch index {
        case 0: allAnnotation()
        case 1: getKoreanFood()
        case 2: getWesternFood()
        case 3: getAsianFood()
        case 4: getEtcFood()
        default: break
        }
    
    }
    


}
// configure
extension RestaurantMapViewController {
    func configureMapView() {
        let location = CLLocationCoordinate2D(latitude: 37.518017, longitude: 126.886696)
        mapView.region = MKCoordinateRegion(center: location, latitudinalMeters: 800, longitudinalMeters: 800)
    }
    
    func configureSegmentColtrol() {
        segmentControl.removeAllSegments()

        for index in 0...filterOptionList.count - 1{
            segmentControl.insertSegment(withTitle: filterOptionList[index], at: index, animated: true)
        }
        
        segmentControl.selectedSegmentIndex = 0
        
    }
    
    func configurFilterLabel(){
        filterLabel.setAdLogoLabel()
        filterLabel.text = "필터"
        filterLabel.backgroundColor = .lightGray.withAlphaComponent(0.2)
        filterLabel.clipsToBounds = true
        filterLabel.layer.cornerRadius = 5
        
        filtertextField.tintColor = .clear
        filtertextField.backgroundColor = .clear
        filtertextField.borderStyle = .none
    }
    
}

// mapView annotation
extension RestaurantMapViewController {
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

extension RestaurantMapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterOptionList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterOptionList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row), \(component)")
        getCategory(index: row)
        
    }
    

}

