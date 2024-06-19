//
//  RestaurantMapViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/30/24.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

enum LocationAuthoriation: String {
    case disabled = "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요"
    case denied = "현재 위치를 찾을 수 없스니다. 기기의 '설정>앱>위치'에서 위치 서비스를 켜주세요"
}

class RestaurantMapViewController: UIViewController {
    

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var filtertextField: UITextField!
    @IBOutlet var filterLabel: UILabel!
    
    var picker = UIPickerView()
    var locationButton = UIButton()
    var list = RestaurantList().restaurantArray
    let locationManager = CLLocationManager()
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.518017, longitude: 126.886696)
    var filterOptionList = ["전체", "한식", "양식", "양식", "아시안", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        
        filtertextField.inputView = picker
        
        picker.delegate = self
        picker.dataSource = self
        locationManager.delegate = self
        
        configureView()
        configureSegmentColtrol()
        configurFilterLabel()
        
        configureMapView(center: defaultLocation)
        
        allAnnotation()

    }
    func configureView() {
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalTo(mapView.snp.leading).inset(20)
            make.top.equalTo(mapView.snp.top).inset(20)
        }
        locationButton.setImage(UIImage(systemName: "scope"), for: .normal)
        locationButton.clipsToBounds = true
        locationButton.layer.cornerRadius = 5
        locationButton.backgroundColor = .white.withAlphaComponent(0.9)
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
    }
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    @objc func locationButtonClicked() {
        print(#function)
        checkDeviceLocationAuthorization()
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
    
    func configureMapView(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
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

extension RestaurantMapViewController {
    // 시스템 설정 확인
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            print(#function)
            let authorization = locationManager.authorizationStatus
            checkCurrentLocationAuthorization(status: authorization)
        } else {
            print("위치서비스가 꺼져있음..^_^")
            showLocationSettingAlert(status: .disabled)
        }
    }
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denied")
            showLocationSettingAlert(status: .denied)
        case .authorizedWhenInUse:
            print("whenInUse")
            locationManager.startUpdatingLocation()
        default:
            print("Error")
        }
    }
    func showLocationSettingAlert(status: LocationAuthoriation) {
        // 1.
        // actionSheet에서는 title, message를 잘 사용하지 않음 => nil 과 ""(빈문자열)은 다름
        let alert = UIAlertController(
            title: "위치 정보 이용",
            message: status.rawValue,
            preferredStyle: .alert)

        let open = UIAlertAction(title: "설정", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(open)
        present(alert, animated: true)
    }

}

extension RestaurantMapViewController: CLLocationManagerDelegate {
    // 위치 가져오기 성공
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 맵뷰에 가져온 위치 넣어주기
        print(#function)
        print(locations)
        if let coordinate = locations.last?.coordinate {
            print(coordinate.latitude, coordinate.longitude)
            configureMapView(center: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        // 맵뷰에 디폴트 위치 넣어주기
        print(#function)
        configureMapView(center: defaultLocation)
    }
    // 권한status바뀔때 실팽됨 + locationManager인스턴스 생성될 때 실행됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 바뀐 권한 체크해주는 거 ~!
        print(#function, manager.authorizationStatus)
        checkDeviceLocationAuthorization()
    }
    
}

