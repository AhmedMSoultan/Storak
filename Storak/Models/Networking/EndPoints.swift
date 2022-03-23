//
//  EndPoints.swift
//  Storak
//
//  Created by Ahmed Soultan on 18/03/2022.
//

import Foundation

//let baseURL = "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/"
let baseURL = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/"


enum EndPoint {
    
    case brandsEndPoint
    case allProductsEndPoint
    case brandProductsEndPoint(String)
    case allProductsBySegmentEndPoint(String)
    case categoryProductsEndPoint(String , String)
    case productImagesEndPoint(String)
    case mainCategoriesEndPoint
    
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
        case .allProductsBySegmentEndPoint(let product_type):
            return baseURL+"products.json?product_type=\(product_type)"
        case .categoryProductsEndPoint(let collection_id , let product_type):
            return baseURL+"products.json?collection_id=\(collection_id)&product_type=\(product_type)"
        case .productImagesEndPoint(let id):
            return baseURL+"products/\(id)/images.json"
        case .mainCategoriesEndPoint:
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
            do {
                let json = try decoder.decode(Brands.self, from: data)
                completionHandler(json.smart_collections, nil)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    
    class func requestAllProducts(completionHandler: @escaping ([Product] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.allProductsEndPoint.url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do{
                let json = try decoder.decode(Products.self, from: data)
                completionHandler(json.products, nil)
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    class func requestBrandProducts( brandID : String , completionHandler: @escaping ([Product] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.brandProductsEndPoint(brandID).url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do{
                let json = try decoder.decode(Products.self, from: data)
                completionHandler(json.products, nil)
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    class func requestCategoryProducts( collectionID : String , productType : String , completionHandler: @escaping ([Product] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.categoryProductsEndPoint(collectionID, productType).url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do{
                let json = try decoder.decode(Products.self, from: data)
                completionHandler(json.products, nil)
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    class func requestAllProductsByProductType(productType : String , completionHandler: @escaping ([Product] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.allProductsBySegmentEndPoint(productType).url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Products.self, from: data)
                completionHandler(json.products, nil)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    class func requestProductImages( productID : String , completionHandler: @escaping ([ProductImage] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.productImagesEndPoint(productID).url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(ProductImages.self, from: data)
                completionHandler(json.images ?? [], nil)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    class func requestMainCategories(completionHandler: @escaping ([MainCategory] , Error?) -> Void){
        let _ = URLSession.shared.dataTask(with: EndPoint.mainCategoriesEndPoint.url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(MainCategories.self, from: data)
                completionHandler(json.custom_collections, nil)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

