//
//  StorakTests.swift
//  StorakTests
//
//  Created by Ahmed Soultan on 10/03/2022.
//
// 6747827109940 productID


import XCTest
@testable import Storak

class StorakTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewControllerUpdatesBrandsAndCategoriesCorrectly() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeVC.service = NetworkLayerMockup(brandsResult: ([Brand(brandId: 2, brandName: "", brandImage: CategoryImage(src: URL(string: "")))], nil), categoriesResult: ([], nil))
        _ = homeVC.view
        XCTAssertEqual(homeVC.arrayOfBrands.count, 1)
        XCTAssertEqual(homeVC.arrayOfMainCategories.count, 0)
    }
    
    func testViewControllerUpdatesAllProductsCorrectly() {
        let productsVC = UIStoryboard(name: "Categories", bundle: nil).instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        productsVC.service = NetworkLayerMockupAllProducts(result: ([], nil))
        _ = productsVC.view
        XCTAssertEqual(productsVC.arrayOfProducts?.count, nil)
    }

}

class NetworkLayerMockup: BrandsAndCategoryProtocol {
    
    let brandsResult: ([Brand], Error?)
    let categoriesResult: ([MainCategory], Error?)
    
    init(brandsResult: ([Brand], Error?), categoriesResult: ([MainCategory], Error?)) {
        self.brandsResult = brandsResult
        self.categoriesResult = categoriesResult
    }
    func requestBrands(completionHandler: @escaping ([Brand], Error?) -> Void) {
        completionHandler(brandsResult.0, brandsResult.1)
    }
    
    func requestMainCategories(completionHandler: @escaping ([MainCategory], Error?) -> Void) {
        completionHandler(categoriesResult.0, categoriesResult.1)

    }
}

class NetworkLayerMockupAllProducts: AllProductsProtocol {
    
    let result: ([Product], Error?)
    
    init(result: ([Product], Error?)) {
        self.result = result
    }
    func requestAllProducts(completionHandler: @escaping ([Product] , Error?) -> Void) {
        completionHandler(result.0, result.1)

    }

}
