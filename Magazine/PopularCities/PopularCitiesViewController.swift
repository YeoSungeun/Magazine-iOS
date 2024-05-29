//
//  PopularCitiesViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/27/24.
//

import UIKit

class PopularCitiesViewController: UIViewController {

    @IBOutlet var citiesTableView: UITableView!
    
    var citiesList = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "도시 상세 정보"
        
        configureTableView()
        
    }
    
    func configureTableView() {
        // tableView 부하직원 연결
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        
        // xib
        let citiesXib = UINib(nibName: CitiesTableViewCell.identifier, bundle: nil)
        let adXib = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        citiesTableView.register(citiesXib, forCellReuseIdentifier: CitiesTableViewCell.identifier)
        citiesTableView.register(adXib, forCellReuseIdentifier: AdTableViewCell.identifier)
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        
        citiesList[sender.tag].like?.toggle()
        
        citiesTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }

}

extension PopularCitiesViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isAd: Bool = citiesList[indexPath.row].ad
        
        if isAd {
            return 100
        } else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isAd: Bool = citiesList[indexPath.row].ad
        let data = citiesList[indexPath.row]
        
        if isAd {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            
            cell.configureAdCell(data: data)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.identifier, for: indexPath) as! CitiesTableViewCell
            
            cell.configureCityCell(data: data)
//
//            let imageName = data.like! ? "heart.fill" : "heart"
//            let image = UIImage(systemName: imageName)
//            cell.likeButton.setImage(image, for: .normal)
//
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = citiesList[indexPath.row]
        
        if data.ad {
            let sb = UIStoryboard(name: "PopularCities", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "AdViewController")
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true)
            
        } else {
            let sb = UIStoryboard(name: "PopularCities", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CityDetailViewController")
            let nav = UINavigationController(rootViewController: vc)
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
