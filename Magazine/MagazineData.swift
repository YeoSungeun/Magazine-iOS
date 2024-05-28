//
//  MagazineData.swift
//  Magazine
//
//  Created by 여성은 on 5/26/24.
//

import Foundation


struct Magazine {
    var title: String
    var subtitle: String
    var photo_image: String
    var date: String
    var link: String
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        let date = dateFormatter.date(from: date) // Date로 변환

        dateFormatter.dateFormat = "yy월 MM월 dd일"
        let dateString = dateFormatter.string(from: date!) // Date String으로 변환

        return dateString
    }
    
    var imageURL: URL? {
        let url = URL(string: photo_image)
        return url
    }
}


