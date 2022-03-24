//
//  HomeViewController.swift
//  Storak
//
//  Created by Ahmed Soultan on 15/03/2022.
//

import UIKit

protocol BrandsAndCategoryProtocol {
    func requestBrands(completionHandler: @escaping ([Brand], Error?) -> Void)
    func requestMainCategories(completionHandler: @escaping ([MainCategory] , Error?) -> Void)
}

class HomeViewController: UIViewController {
    
    var timer : Timer?
    var currentIndexItem = 0
    var selectedBrand : Brand?
    var selectedCategory : String?
    
    let arrayOfAds = [UIImage(named: "Banner-1"),
                      UIImage(named: "Banner-2"),
                      UIImage(named: "Banner-3"),
                      UIImage(named: "Banner-4"),
                      UIImage(named: "Banner-5")]
    
    var arrayOfBrands = [Brand]()
    var arrayOfMainCategories = [MainCategory]()
    var arrayOfCategoriesImages = [UIImage(named: "Home page"),
                                   UIImage(named: "KID"),
                                   UIImage(named: "MEN"),
                                   UIImage(named: "SALE"),
                                   UIImage(named: "WOMEN")]
    
    var service: BrandsAndCategoryProtocol = NetworkLayer()
    
    
    @IBOutlet weak var adsCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adsCollectionView.delegate = self
        adsCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
        categoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "categoryCell")
        brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "brandsCell")
        
        service.requestMainCategories { mainCategories, error in
            self.arrayOfMainCategories = mainCategories
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
            }
        }
        
        service.requestBrands { brands, error in
            self.arrayOfBrands = brands
            DispatchQueue.main.async {
                self.brandsCollectionView.reloadData()
            }
        }
        
        pageControl.numberOfPages = arrayOfAds.count
        startTimer()
        
        
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNext(){
        if(currentIndexItem < arrayOfAds.count - 1){
            currentIndexItem += 1
        }else{
            currentIndexItem = 0
        }
        pageControl.currentPage = currentIndexItem
        adsCollectionView.scrollToItem(at: IndexPath(row: currentIndexItem, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cartScreen"){
//            let cartVC = segue.destination as! CartViewController
        }else if(segue.identifier == "categoryProducts"){
            let categoryProductsVC = segue.destination as! ProductsViewController
            categoryProductsVC.collectionID = selectedCategory ?? ""
        }
    }
    
    @IBAction func cartBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "cartScreen", sender: self)
    }
    
    @IBAction func wishlistBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "wishlistSegue", sender: self)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            if(collectionView == adsCollectionView){
                return arrayOfAds.count
            }else if(collectionView == categoriesCollectionView){
                return arrayOfMainCategories.count
            }else if (collectionView == brandsCollectionView){
                return arrayOfBrands.count
            }
            return 0
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if(collectionView == adsCollectionView){
                let adsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
                adsCell.adImage.image = arrayOfAds[indexPath.row]
                
                adsCell.layer.masksToBounds = false
                adsCell.layer.cornerRadius = 8
                return adsCell
                
            }else if(collectionView == categoriesCollectionView){
                let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
                
                let category = arrayOfMainCategories[indexPath.row]
                categoryCell.setUpCell(categoryName: category.categoryName!, categoryImg: category.categoryName!)
                
                categoryCell.layer.backgroundColor = UIColor.white.cgColor
                categoryCell.layer.masksToBounds = false
                categoryCell.layer.cornerRadius = 5
                categoryCell.layer.shadowRadius = 7
                categoryCell.layer.shadowOpacity = 0.1
                categoryCell.layer.shadowColor = UIColor.black.cgColor
                categoryCell.layer.shadowOffset = CGSize(width: 3, height: 3 )
                return categoryCell
                
            }else if (collectionView == brandsCollectionView){
                let brandsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath) as! BrandsCollectionViewCell
                
                let brand = arrayOfBrands[indexPath.row]
                let imageURL = brand.brandImage?.src
                brandsCell.setUpCell(brandImage: imageURL!, brandName: brand.brandName ?? "")
                
                brandsCell.layer.backgroundColor = UIColor.white.cgColor
                brandsCell.layer.masksToBounds = false
                brandsCell.layer.cornerRadius = 8
                brandsCell.layer.shadowRadius = 7
                brandsCell.layer.shadowOpacity = 0.1
                brandsCell.layer.shadowColor = UIColor.black.cgColor
                brandsCell.layer.shadowOffset = CGSize(width: 3, height: 3 )
                return brandsCell
            }
            let adsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
            adsCell.adImage.image = arrayOfAds[indexPath.row]
            return adsCell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == categoriesCollectionView){
            let categoryID = "\(arrayOfMainCategories[indexPath.row].categoryId)"
            selectedCategory = categoryID
            performSegue(withIdentifier: "categoryProducts", sender: self)
        }
        else if(collectionView == brandsCollectionView){
            let brandID = "\(arrayOfBrands[indexPath.row].brandId)"
            selectedCategory = brandID
            performSegue(withIdentifier: "categoryProducts", sender: self)
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if(collectionView == adsCollectionView){
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            }else if (collectionView == categoriesCollectionView){
                return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/1.3 )
            }else if (collectionView == brandsCollectionView){
                return CGSize(width: collectionView.frame.width / 2.1, height: collectionView.frame.height / 2.1)
            }
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            if(collectionView == adsCollectionView){
                return 0
            }else if (collectionView == categoriesCollectionView){
                return 10
            }else if (collectionView == brandsCollectionView){
                return 10
            }
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int)-> CGFloat {
            if(collectionView == adsCollectionView){
                return 0
            }else if (collectionView == categoriesCollectionView){
                return 10
            }else if (collectionView == brandsCollectionView){
                return 0
            }
            return 10
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == brandsCollectionView){
            return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        }else if(collectionView == categoriesCollectionView){
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
