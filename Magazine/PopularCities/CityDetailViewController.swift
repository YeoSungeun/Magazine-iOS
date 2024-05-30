//
//  CityDetailViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/29/24.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popButtonClicked))
        leftItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.title = data?.title
        
        configureDetailView()

    }
    
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureDetailView() {
        imageView.kf.setImage(with: data?.travelImgaeURL)
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        imageView.layer.cornerRadius = 10
        
        titleLabel.text = data?.title
        titleLabel.setBigTitleLabel()
        
        descriptionLabel.text = data?.description
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        gradeLabel.text = "(\(data?.grade ?? 0.0))"
        gradeLabel.font = .systemFont(ofSize: 14)
        gradeLabel.textColor = .gray
        saveLabel.text = "저장 \(data?.save?.formatted() ?? "0")"
        saveLabel.font = .systemFont(ofSize: 14)
        saveLabel.textColor = .gray
    }

}

