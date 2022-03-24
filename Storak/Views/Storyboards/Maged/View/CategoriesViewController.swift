//
//  CategoriesViewController.swift
//  Storak
//
//  Created by Mohamed Maged on 11/03/2022.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    var selectedCategory : String?
    var arrayOfMainCategories = [MainCategory]()
    var arrayOfCategoriesImages = [UIImage(named: "Home page"),
                                   UIImage(named: "KID"),
                                   UIImage(named: "MEN"),
                                   UIImage(named: "SALE"),
                                   UIImage(named: "WOMEN")]
    
    var service: BrandsAndCategoryProtocol = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        service.requestMainCategories { mainCategories, error in
            self.arrayOfMainCategories = mainCategories
            DispatchQueue.main.async {
                self.categoriesTableView.reloadData()
            }
        }
        
        let wishlistVC = self.storyboard?.instantiateViewController(withIdentifier: "WishListViewController") as! WishListViewController
        NotificationCenter.default.addObserver(wishlistVC, selector: #selector(wishlistVC.addItemToWishlist), name: Notification.Name("addToWishlist"), object: nil)
    }
    
   private func configureTableView() {
        categoriesTableView.register(cellType: CategoryCell.self)
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CategoryProductsSegue"){
            let categoryProductsVC = segue.destination as! ProductsViewController
            categoryProductsVC.collectionID = selectedCategory ?? ""
        }
    }
    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMainCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: CategoryCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        let category = arrayOfMainCategories[indexPath.row]
        cell.setupCell(categoryName: category.categoryName ?? "", categoryImage: category.categoryName ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryID = "\(arrayOfMainCategories[indexPath.row].categoryId)"
        selectedCategory = categoryID
        performSegue(withIdentifier: "CategoryProductsSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
}
