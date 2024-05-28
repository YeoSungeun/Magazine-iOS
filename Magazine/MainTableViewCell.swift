//
//  MainTableViewCell.swift
//  Magazine
//
//  Created by 여성은 on 5/25/24.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    func configureLayout() {
        photoImageView.setImageView()
        
        titleLabel.setBigTitleLabel()
        
        subTitleLabel.textColor = .gray
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        dateLabel.setSubLabel()
    }
    
    func configureData(data: Magazine) {
        
        titleLabel.text = data.title
        subTitleLabel.text = data.subtitle
        dateLabel.text = data.dateString
        photoImageView.kf.setImage(with: data.imageURL)
    }
    
}
