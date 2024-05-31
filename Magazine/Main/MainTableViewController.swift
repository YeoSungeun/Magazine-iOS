//
//  MainTableViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/25/24.
//

import UIKit
import Kingfisher

class MainTableViewController: UITableViewController {
    
    var magazineList = MagazineInfo().magazine

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SeSAC TRAVEL"
        
        // 2. 셀 높이
        tableView.rowHeight = 500
  
    }
    
    // 1.셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        
        return magazineList.count
    }
    
    // 3. 셀 디자인 / 셀 데이터 넣기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        cell.configureLayout()
        cell.configureData(data: magazineList[indexPath.row])
    
        return cell
    }


}
