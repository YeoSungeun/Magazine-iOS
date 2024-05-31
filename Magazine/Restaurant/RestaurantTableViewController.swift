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

        configureView()
        
        searchResultList = restaurantList
        setSearchTextFieldAndButton()
    
        tableView.rowHeight = 220
    }
    
    func configureView() {
        let map = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonClicked))
        navigationItem.rightBarButtonItem = map
    }
    
    @objc func mapButtonClicked() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "RestaurantMapViewController") as? RestaurantMapViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.configureLayout()
        cell.configureData(data: restaurantList[indexPath.row])
   
        // 코드로 버튼에 태그 설정하기
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }

}
