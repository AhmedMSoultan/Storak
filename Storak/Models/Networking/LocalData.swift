//
//  LocalData.swift
//  Storak
//
//  Created by Ahmed Soultan on 23/03/2022.
//

import Foundation


class localDataLayer {
    
    static var arrayOfWishedProducts = [Product]()
    static var arrayOfCartProducts = [Product]()
    
    // MARK: - Saving wishListItems
    
    class func saveWishedProducts() {
        // 1
        let encoder = PropertyListEncoder()
        
        // 2
        do {
            // 3
            let data = try encoder.encode(arrayOfWishedProducts.self)
            // 4
            try data.write(to: wishlistFilePath(), options: Data.WritingOptions.atomic)
        } catch { // 5
            // 6
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Loading wishListItems
    
    class func loadWishedProducts() {
        let path = wishlistFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            
            do {
                arrayOfWishedProducts = try decoder.decode([Product]?.self, from: data)!
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    class func wishlistFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Wishlist.plist")
    }
    
    
    
    // MARK: - Cart Data
    
    class func saveCartProducts() {
        // 1
        let encoder = PropertyListEncoder()
        
        // 2
        do {
            // 3
            let data = try encoder.encode(arrayOfCartProducts.self)
            // 4
            try data.write(to: cartFilePath(), options: Data.WritingOptions.atomic)
        } catch { // 5
            // 6
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Loading CartItems
    
    class func loadCartProducts() {
        let path = cartFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            
            do {
                arrayOfCartProducts = try decoder.decode([Product]?.self, from: data)!
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    class func cartFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Cart.plist")
    }

    // ---------------------------------
    class func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
}
