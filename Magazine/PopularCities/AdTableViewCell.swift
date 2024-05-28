//
//  AdTableViewCell.swift
//  Magazine
//
//  Created by 여성은 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    static let identifier = "AdTableViewCell"
    
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
        
        titleLabel.settitleLabel()
        titleLabel.textAlignment = .center
        
        adLogoLabel.setAdLogoLabel()
    }

    func configureAdCell(data: Travel) {
        print(#function)
        
        titleLabel.text = data.title
    }
    
    
}
