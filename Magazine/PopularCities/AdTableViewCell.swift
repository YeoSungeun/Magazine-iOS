//
//  AdTableViewCell.swift
//  Magazine
//
//  Created by 여성은 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    @IBOutlet var adView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var adLogoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAdLayout()
    }

    func configureAdLayout() {
        print(#function)
        adView.layer.cornerRadius = 30
        adView.backgroundColor = .systemPink.withAlphaComponent(0.2)
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        adLogoLabel.text = " AD "
        adLogoLabel.font = .boldSystemFont(ofSize: 14)
        adLogoLabel.layer.cornerRadius = 5
        adLogoLabel.layer.masksToBounds = true
        adLogoLabel.backgroundColor = .white
    }

    func configureAdCell(data: Travel) {
        print(#function)
        
        titleLabel.text = data.title
    }
    
    
}
