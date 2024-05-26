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
    
    func dateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        let date = dateFormatter.date(from: dateString) // dateString Date로 변환

        dateFormatter.dateFormat = "yy월 MM월 dd일"
        let mydate = dateFormatter.string(from: date!) // Date String으로 변환

        return mydate

    }
    
    // 1.셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        
        return magazineList.count
    }
    
    // 3. 셀 디자인 / 셀 데이터 넣기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        let url = URL(string: magazineList[indexPath.row].photo_image)
        cell.photoImageView.kf.setImage(with: url)
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.layer.cornerRadius = 10
        
        cell.titleLabel.text = magazineList[indexPath.row].title
        cell.titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        cell.titleLabel.numberOfLines = 0
        
        cell.subTitleLabel.text = magazineList[indexPath.row].subtitle
        cell.subTitleLabel.textColor = .gray
        cell.subTitleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        cell.dateLabel.text = dateFormat(dateString: magazineList[indexPath.row].date)
        cell.dateLabel.textColor = .gray
        cell.dateLabel.font = .systemFont(ofSize: 12)
        
        
        
        return cell
    }


}
