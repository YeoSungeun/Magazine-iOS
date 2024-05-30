//
//  AdViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
 
        configureAdView()
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func configureAdView() {
        titleLabel.text = data?.title
        titleLabel.textAlignment = .center
        titleLabel.setBigTitleLabel()
        backgroundView.backgroundColor = .systemPink.withAlphaComponent(0.2)
        view.backgroundColor = .white
        
    
    }
}
