//
//  CitiesTableViewCell.swift
//  Magazine
//
//  Created by 여성은 on 5/27/24.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    
    @IBOutlet var travel_imageView: UIImageView!
    
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCityLayout()
    }

    func configureCityLayout() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        descriptionLabel.font  = .systemFont(ofSize: 13, weight: .semibold)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        
        gradeLabel.setSubLabel()
        
        saveLabel.setSubLabel()
        
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .white
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        travel_imageView.contentMode = .scaleAspectFill
        travel_imageView.layer.cornerRadius = 10
    }
    
    func configureCityCell(data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        gradeLabel.text = "(\(data.grade ?? 0))"
        saveLabel.text = "저장 " + (data.save?.formatted() ?? "")
        let url = URL(string: data.travel_image ?? "")
        travel_imageView.kf.setImage(with: url)

    }
    
}
