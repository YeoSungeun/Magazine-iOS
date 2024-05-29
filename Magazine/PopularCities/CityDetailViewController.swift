//
//  CityDetailViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/29/24.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popButtonClicked))
        leftItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.title = "관광지 화면"
        
        titleLabel.text = "관광지 화면"
        titleLabel.setBigTitleLabel()
        titleLabel.textAlignment = .center

    }
    
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
