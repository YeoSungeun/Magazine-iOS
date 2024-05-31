//
//  CityListTableViewCell.swift
//  Magazine
//
//  Created by 여성은 on 5/30/24.
//

import UIKit
import Kingfisher

class CityListTableViewCell: UITableViewCell {
    
    static let identifier = "CityListTableViewCell"
    
    
    @IBOutlet var cityCellUIView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var subTitleBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        
        configureLayout()
    }
    
    func configureLayout() {
        cityCellUIView.clipsToBounds = true
        cityCellUIView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cityCellUIView.layer.cornerRadius = cityCellUIView.frame.height * 0.15
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
        
        subTitleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        subTitleLabel.textColor = .white
        
        subTitleBackgroundView.backgroundColor = .black.withAlphaComponent(0.5)
        
        cityImageView.contentMode = .scaleAspectFill
        
    }
    
    func configureData(data: City) {
        titleLabel.text = data.krUsTitle
        subTitleLabel.text = data.city_explain
        cityImageView.kf.setImage(with: data.imageURL)
        
    }
    
}
