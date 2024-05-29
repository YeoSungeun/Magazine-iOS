//
//  AdViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        closeButton.tintColor = .black
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = closeButton
        
        titleLabel.text = "광고 화면"
        titleLabel.setBigTitleLabel()
        titleLabel.textAlignment = .center
 
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }


}
