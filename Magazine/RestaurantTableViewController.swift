//
//  RestaurantTableViewController.swift
//  Magazine
//
//  Created by 여성은 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    var restaurantList = RestaurantList().restaurantArray
    var searchResultList: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultList = restaurantList
        setSearchTextFieldAndButton()
    
        tableView.rowHeight = 220
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        guard let result = searchTextField.text, result.count > 0 else {
            searchTextField.text = "검색결과가 없습니다."
            return
        }
        
        searchResultList.removeAll()
        for restaurant in restaurantList {
            if restaurant.category.contains(result) || restaurant.name.contains(result) {
                searchResultList.append(restaurant)
            }
        }
        print(searchResultList)
        tableView.reloadData()
    }
    
    @IBAction func returnKeyClicked(_ sender: UITextField) {
        print(#function)
        guard let result = searchTextField.text, result.count > 0 else {
            searchTextField.text = "검색결과가 없습니다."
            
            return
        }
        
        searchResultList.removeAll()
        for restaurant in restaurantList {
            if restaurant.category.contains(result) || restaurant.name.contains(result) {
                searchResultList.append(restaurant)
            }
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func TextFieldClicked(_ sender: UITextField) {
        print(#function)
        searchTextField.text = ""
        tableView.reloadData()
    }
    
    
    func setSearchTextFieldAndButton() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.backgroundColor = .lightGray
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        searchButton.layer.cornerRadius = 5
        
        searchTextField.placeholder = "검색어를 입력하세요"
        
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        
        searchResultList[sender.tag].like.toggle()
        
        if let index = restaurantList.firstIndex(where: { $0.name == searchResultList[sender.tag].name }) {
            restaurantList[index].like.toggle()
        }
     
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        print(#function)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchResultList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        
        let url = URL(string: searchResultList[indexPath.row].image)
        cell.restaurantImageView.kf.setImage(with: url)
        cell.restaurantImageView.contentMode = .scaleAspectFill
        cell.restaurantImageView.layer.cornerRadius = 10
        
        cell.categoryLabel.text = searchResultList[indexPath.row].category
        cell.categoryLabel.textColor = .white
        cell.categoryLabel.font = .systemFont(ofSize: 14, weight: .bold)
        cell.categoryLabel.layer.cornerRadius = 3
        cell.categoryLabel.layer.masksToBounds = true
        var categoryColor = UIColor.clear
        switch searchResultList[indexPath.row].category {
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
        cell.categoryLabel.backgroundColor = categoryColor
        
        
        
        cell.nameLabel.text = searchResultList[indexPath.row].name
        cell.nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        cell.nameLabel.numberOfLines = 0
        
        cell.addressLabel.text = "주소: \(searchResultList[indexPath.row].address)"
        cell.addressLabel.textColor = .darkGray
        cell.addressLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        cell.addressLabel.numberOfLines = 0
        
        cell.phoneNumberLabel.text = "전화번호: \(searchResultList[indexPath.row].phoneNumber)"
        cell.phoneNumberLabel.textColor = .darkGray
        cell.phoneNumberLabel.font = .systemFont(ofSize: 14)
        
        cell.likeButton.setTitle("", for: .normal)
        let name = searchResultList[indexPath.row].like ? "heart.fill" : "heart"
        let image = UIImage(systemName: name)
        cell.likeButton.setImage(image, for: .normal)
        cell.likeButton.tintColor = .systemPink
        
        // 코드로 버튼에 태그 설정하기
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }

}
