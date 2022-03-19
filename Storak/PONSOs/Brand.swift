//
//  Brand.swift
//  Storak
//
//  Created by Ahmed Soultan on 18/03/2022.
//

import Foundation

struct Brand : Codable{
    let brandId : Int
    let brandName : String?
    let brandImage : CategoryImage?
    
    enum CodingKeys: String, CodingKey {
        case brandId = "id"
        case brandName = "title"
        case brandImage = "image"
    }
    
}

struct Brands : Codable {
    let smart_collections : [Brand]
}

