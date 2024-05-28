//
//  UIImage+Extension.swift
//  Magazine
//
//  Created by 여성은 on 5/29/24.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageView() {
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 10
    }
}
