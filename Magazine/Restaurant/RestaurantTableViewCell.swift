//
//  RestaurantTableViewCell.swift
//  Magazine
//
//  Created by 여성은 on 5/26/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantTableViewCell"

    @IBOutlet var restaurantImageView: UIImageView!

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    func configureLayout() {
        restaurantImageView.setImageView()
        
        categoryLabel.textColor = .white
        categoryLabel.font = .systemFont(ofSize: 14, weight: .bold)
        categoryLabel.layer.cornerRadius = 3
        categoryLabel.layer.masksToBounds = true
        
        nameLabel.settitleLabel()
        
        addressLabel.textColor = .darkGray
        addressLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        addressLabel.numberOfLines = 0
        
        phoneNumberLabel.textColor = .darkGray
        phoneNumberLabel.font = .systemFont(ofSize: 14)
        
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .systemPink
    }
    
    func configureData(data: Restaurant) {
        let url = URL(string: data.image)
        restaurantImageView.kf.setImage(with: url)
        
        categoryLabel.text = data.category
        
        var categoryColor = UIColor.clear
        switch data.category {
        case "한식":
            categoryColor = .orange.withAlphaComponent(0.5)
        case "양식":
            categoryColor = .systemPink.withAlphaComponent(0.5)
        case "분식":
            categoryColor = .red.withAlphaComponent(0.5)
        case "카페":
            categoryColor = .blue.withAlphaComponent(0.5)
        case "중식":
            categoryColor = .brown.withAlphaComponent(0.5)
        case "일식":
            categoryColor = .green.withAlphaComponent(0.5)
        case "경양식":
            categoryColor = .yellow.withAlphaComponent(0.5)
        default:
            categoryColor = .gray
            break
        }
        categoryLabel.backgroundColor = categoryColor
        
        nameLabel.text = data.name
        addressLabel.text = "주소: \(data.address)"
        phoneNumberLabel.text = "전화번호: \(data.phoneNumber)"
        
        let imgaename = data.like ? "heart.fill" : "heart"
        let image = UIImage(systemName: imgaename)
        likeButton.setImage(image, for: .normal)
        
    }
    
}

