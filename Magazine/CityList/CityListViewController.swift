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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "인기도시"
        configureTableView()

    }

}

extension CityListViewController {
    func configureTableView() {
        
        citylistTableView.delegate = self
        citylistTableView.dataSource = self
        
        let xib = UINib(nibName: CityListTableViewCell.identifier, bundle: nil)
        citylistTableView.register(xib, forCellReuseIdentifier: CityListTableViewCell.identifier)
        
        citylistTableView.rowHeight = 200
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citylistTableView.dequeueReusableCell(withIdentifier: CityListTableViewCell.identifier, for: indexPath) as! CityListTableViewCell
        
        cell.configureLayout()
        cell.configureData(data: list[indexPath.row])
        
        return cell
    }
    
    
}
