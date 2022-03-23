//
//  MainCategory.swift
//  Storak
//
//  Created by Ahmed Soultan on 18/03/2022.
//

import Foundation

struct MainCategory : Codable{
    let categoryId : Int
    let categoryName : String?
    let categoryImage : CategoryImage?
    
    enum CodingKeys : String , CodingKey {
        case categoryId = "id"
        case categoryName = "title"
        case categoryImage = "image"
    }
}


struct MainCategories : Codable {
    let custom_collections : [MainCategory]
}


struct CategoryImage : Codable{
    let src : URL?
}
