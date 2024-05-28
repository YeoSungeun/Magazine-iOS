//
//  UILabel+Extension.swift
//  Magazine
//
//  Created by 여성은 on 5/28/24.
//


import UIKit

extension UILabel {
    func setSubLabel() {
        self.font = .systemFont(ofSize: 12)
        self.textColor = .gray
    }
    
    func settitleLabel() {
        self.font = .boldSystemFont(ofSize: 17)
        self.numberOfLines = 0
    }
    
    func setAdLogoLabel() {
        self.text = " AD "
        self.font = .boldSystemFont(ofSize: 14)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = .white
    }
}
