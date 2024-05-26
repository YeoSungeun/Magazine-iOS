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
    
    var searchBool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchTextFieldAndButton()
        
        tableView.rowHeight = 220
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        guard let result = searchTextField.text, result.count > 0 else {
            searchTextField.text = "검색결과가 없습니다."
            return
        }
        
        searchBool = true
        
        for restaurant in restaurantList {
            if restaurant.category == result {
                searchResultList.append(restaurant)
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func returnKeyClicked(_ sender: UITextField) {
        print(#function)
        guard let result = searchTextField.text, result.count > 0 else {
            searchTextField.text = "검색결과가 없습니다."
            
            return
        }
        
        searchBool = true
        searchResultList.removeAll()
        for restaurant in restaurantList {
            if restaurant.category == result {
                searchResultList.append(restaurant)
            }
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func TextFieldClicked(_ sender: UITextField) {
        print(#function)
        searchTextField.text = ""
        searchBool = false
        tableView.reloadData()
    }
    
    
    func setSearchTextFieldAndButton() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.backgroundColor = .lightGray
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        searchButton.layer.cornerRadius = 5
        
        searchTextField.placeholder = "카테고리를 검색하세요"
        
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        if searchBool {
            searchResultList[sender.tag].like.toggle()
        } else {
            restaurantList[sender.tag].like.toggle()
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        print(#function)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBool{
            return searchResultList.count
        } else {
            return restaurantList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        var list: [Restaurant] = []
        
        if searchBool{
            list = searchResultList
        } else {
            list = restaurantList
        }
        
        let url = URL(string: list[indexPath.row].image)
        cell.restaurantImageView.kf.setImage(with: url)
        cell.restaurantImageView.contentMode = .scaleAspectFill
        cell.restaurantImageView.layer.cornerRadius = 10
        
        cell.categoryLabel.text = list[indexPath.row].category
        cell.categoryLabel.textColor = .white
        cell.categoryLabel.font = .systemFont(ofSize: 14, weight: .bold)
        cell.categoryLabel.layer.cornerRadius = 3
        cell.categoryLabel.layer.masksToBounds = true
        var categoryColor = UIColor.clear
        switch list[indexPath.row].category {
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
        
        
        
        cell.nameLabel.text = list[indexPath.row].name
        cell.nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        cell.nameLabel.numberOfLines = 0
        
        cell.addressLabel.text = "주소: \(list[indexPath.row].address)"
        cell.addressLabel.textColor = .darkGray
        cell.addressLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        cell.addressLabel.numberOfLines = 0
        
        cell.phoneNumberLabel.text = "전화번호: \(list[indexPath.row].phoneNumber)"
        cell.phoneNumberLabel.textColor = .darkGray
        cell.phoneNumberLabel.font = .systemFont(ofSize: 14)
        
        cell.likeButton.setTitle("", for: .normal)
        let name = list[indexPath.row].like ? "heart.fill" : "heart"
        let image = UIImage(systemName: name)
        cell.likeButton.setImage(image, for: .normal)
        cell.likeButton.tintColor = .systemPink
        
        // 코드로 버튼에 태그 설정하기
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }

}
