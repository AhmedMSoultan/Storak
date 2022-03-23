//
//  Product.swift
//  Storak
//
//  Created by Ahmed Soultan on 18/03/2022.
//

import Foundation


class Product: NSObject, Codable {
    
    let productId : Int
    let productName : String?
    let productDescription : String?
    let productVendor : String?
    let productType : String?
    let variants: [Variants]?
    let images: [ProductImage]?
    
    
    enum CodingKeys: String, CodingKey {
        case productId = "id"
        case productName = "title"
        case productDescription = "body_html"
        case productVendor = "vendor"
        case productType = "product_type"
        case variants = "variants"
        case images = "images"
    }
    
}



struct Variants: Codable {
    let price: String?
    let inventory_item_id: Int?
    let inventory_quantity: Int?
    let old_inventory_quantity: Int?
    let option2 : String?
}

struct ProductImage: Codable {
    let id: Int
    let product_id: Int
    let src: URL?
}

struct ProductImages: Codable {
    let images: [ProductImage]?
}

struct Products : Codable {
    let products : [Product]
}
