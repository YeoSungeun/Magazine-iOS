//
//  CityListViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/30/24.
//

import UIKit

class CityListViewController: UIViewController {
    
    @IBOutlet var segmentBar: UISegmentedControl!
    
    @IBOutlet var citylistTableView: UITableView!
    
    var list = CityInfo().city
    var filteredlist: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "인기도시"
        configureTableView()
        congfigureSegmentBar()

    }
    
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        print("\(sender.selectedSegmentIndex)")
        
        if sender.selectedSegmentIndex == 0 {
            filteredlist = list
            citylistTableView.reloadData()
            
        } else if sender.selectedSegmentIndex == 1 {
            var domesticList:[City] = []
            for city in list {
                if city.domestic_travel {
                    domesticList.append(city)
                }
            }
            filteredlist = domesticList
            citylistTableView.reloadData()
            
        } else if sender.selectedSegmentIndex == 2 {
            var aboardList:[City] = []
            for city in list {
                if city.domestic_travel == false {
                    aboardList.append(city)
                }
            }
            filteredlist = aboardList
            citylistTableView.reloadData()
            
        }
    }
    
}

extension CityListViewController {
    func configureTableView() {
        
        citylistTableView.delegate = self
        citylistTableView.dataSource = self
        
        let xib = UINib(nibName: CityListTableViewCell.identifier, bundle: nil)
        citylistTableView.register(xib, forCellReuseIdentifier: CityListTableViewCell.identifier)
        
        citylistTableView.rowHeight = 200
        citylistTableView.separatorStyle = .none
        
        filteredlist = list

    }
    
    func congfigureSegmentBar() {
        segmentBar.removeAllSegments()
        
        segmentBar.insertSegment(withTitle: "모두", at: 0, animated: true)
        segmentBar.insertSegment(withTitle: "국내", at: 1, animated: true)
        segmentBar.insertSegment(withTitle: "해외", at: 2, animated: true)
        
        segmentBar.selectedSegmentIndex = 0
        // MARK: segment여기부터
//        segmentBar.addTarget(self, action: #selector(segmentButtonClicked), for: .touchUpInside)
        
    }
    
//    @objc func segmentButtonClicked(sender: UISegmentedControl) {
//        print("\(sender.selectedSegmentIndex)")
//    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citylistTableView.dequeueReusableCell(withIdentifier: CityListTableViewCell.identifier, for: indexPath) as! CityListTableViewCell
        
        cell.configureLayout()
        cell.configureData(data: filteredlist[indexPath.row])
        
        return cell
    }
    
    
}
