//
//  HomeViewController.swift
//  Storak
//
//  Created by Ahmed Soultan on 15/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var timer : Timer?
    var currentIndexItem = 0
    
    let arrayOfProducts = [UIImage(named: "Banner1"),UIImage(named: "Banner3"),UIImage(named: "Banner1"),UIImage(named: "Banner3"),UIImage(named: "Banner1"),UIImage(named: "Banner3"),UIImage(named: "Banner1"),UIImage(named: "Banner3"),UIImage(named: "Banner1"),UIImage(named: "Banner3"),UIImage(named: "Banner1"),UIImage(named: "Banner3")]
    
    let arrayOfCategories = [Category(name: "Furniture", image: "Path541"),Category(name: "Home Decor", image: "Path544"),Category(name: "Lightning", image: "Path542"),Category(name: "Serveware", image: "Path545"),Category(name: "Furniture", image: "Path541"),Category(name: "Home Decor", image: "Path544"),Category(name: "Serveware", image: "Path545"),Category(name: "Furniture", image: "Path541"),Category(name: "Home Decor", image: "Path544")]
    
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
        
        pageControl.numberOfPages = arrayOfProducts.count
        startTimer()
        
        NetworkLayer.requestProductImages(productID: "6905518063663") { images, error in
            print(images)
        }
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNext(){
        if(currentIndexItem < arrayOfProducts.count - 1){
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
        }
    }
    
    @IBAction func cartBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "cartScreen", sender: self)
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            if(collectionView == adsCollectionView){
                return arrayOfProducts.count
            }else if(collectionView == categoriesCollectionView){
                return arrayOfCategories.count
            }else if (collectionView == brandsCollectionView){
                return arrayOfCategories.count
            }
            return 0
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if(collectionView == adsCollectionView){
                let adsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
                adsCell.adImage.image = arrayOfProducts[indexPath.row]
                return adsCell
            }else if(collectionView == categoriesCollectionView){
                let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
                let category = arrayOfCategories[indexPath.row]
                categoryCell.setUpCell(categoryName: category.name, categoryImg: category.image)
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
                let brand = arrayOfCategories[indexPath.row]
                brandsCell.setUpCell(brandImage: brand.image, brandName: brand.name)
                brandsCell.layer.backgroundColor = UIColor.white.cgColor
                brandsCell.layer.masksToBounds = false
                brandsCell.layer.cornerRadius = 5
                brandsCell.layer.shadowRadius = 7
                brandsCell.layer.shadowOpacity = 0.1
                brandsCell.layer.shadowColor = UIColor.black.cgColor
                brandsCell.layer.shadowOffset = CGSize(width: 3, height: 3 )
                return brandsCell
            }
            let adsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
            adsCell.adImage.image = arrayOfProducts[indexPath.row]
            return adsCell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if(collectionView == adsCollectionView){
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
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
            return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let categoriesHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoriesHeader", for: indexPath) as! CategoriesHeaderReusableView
//        categoriesHeader.categoriesHeader.text = "Categories"
//        return categoriesHeader
//    }
            // Do any additional setup after loading the view.
    }
