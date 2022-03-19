//
//  EndPoints.swift
//  Storak
//
//  Created by Ahmed Soultan on 18/03/2022.
//

import Foundation

let baseURL = "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/"

enum EndPoint {
    
    case brandsEndPoint
    case allProductsEndPoint
    case brandProductsEndPoint(String)
    case productImagesEndPoint(String)
    case subCategoriesEndPoint
    
    var url: URL {
        return URL(string: self.stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .brandsEndPoint:
            print(baseURL+"smart_collections.json")
            return baseURL+"smart_collections.json"
        case .allProductsEndPoint:
            return baseURL+"products.json"
        case .brandProductsEndPoint(let id):
            return baseURL+"products.json?collection_id=\(id)"
        case .productImagesEndPoint(let id):
            return baseURL+"products/\(id)/images.json"
        case .subCategoriesEndPoint:
            return baseURL+"custom_collections.json"
        }
    }
    
}


class NetworkLayer {
    class func requestBrands(completionHandler: @escaping ([Brand], Error?) -> Void ) {
        let _ = URLSession.shared.dataTask(with: EndPoint.brandsEndPoint.url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let json = try! decoder.decode(Brands.self, from: data)
            completionHandler(json.smart_collections, nil)
        }.resume()
    }
    
    
    
    class func requestAllProducts(completionHandler: @escaping ([Product] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.allProductsEndPoint.url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let json = try! decoder.decode(Products.self, from: data)
            completionHandler(json.products, nil)
        }.resume()
    }
    
    class func requestBrandProducts( brandID : String , completionHandler: @escaping ([Product] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.brandProductsEndPoint(brandID).url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let json = try! decoder.decode(Products.self, from: data)
            completionHandler(json.products, nil)
        }.resume()
    }
    
    class func requestProductImages( productID : String , completionHandler: @escaping ([ProductImage] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.productImagesEndPoint(productID).url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let json = try! decoder.decode(ProductImages.self, from: data)
            completionHandler(json.images ?? [], nil)
        }.resume()
    }
    
    class func requestSubCategories(completionHandler: @escaping ([MainCategory] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.subCategoriesEndPoint.url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let json = try! decoder.decode(MainCategories.self, from: data)
            completionHandler(json.custom_collections, nil)
        }.resume()
    }
    
}

