//
//  ProductsViewController.swift
//  Storak
//
//  Created by Mohamed Maged on 17/03/2022.
//

import UIKit

protocol AllProductsProtocol {
    func requestAllProducts(completionHandler: @escaping ([Product] , Error?) -> Void)
}

class ProductsViewController: UIViewController {
    
    var selectedSegment: Int!
    var collectionID : String?
    var productType : String?
    var arrayOfProducts : [Product]?
    var selectedProduct : Product?
    var isWished = false
    
    var arrayOfWishedProducts = localDataLayer.arrayOfWishedProducts
    
    var service: AllProductsProtocol = NetworkLayer()
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var productsCollectionView: UICollectionView!
  
    @IBAction func switchSelectedSegment(_ sender: UISegmentedControl) {
        
        selectedSegment = sender.selectedSegmentIndex
        updateData()
        self.detectingCurrentSegmant()
    }
    
    @IBAction func cartButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "CartSegue", sender: self)
    }
    @IBAction func wishlistButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "WishListSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedSegment = 0
        productsCollectionView.register(UINib(nibName: "ItemCell", bundle: .main), forCellWithReuseIdentifier: "itemCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.detectingCurrentSegmant()
        updateData()
    }
    
    func updateData(){
        localDataLayer.loadWishedProducts()
        arrayOfWishedProducts = localDataLayer.arrayOfWishedProducts
    }
    
    func detectingCurrentSegmant(){
        if(selectedSegment == 0){
            if(collectionID == "272068509743"){
                service.requestAllProducts { products , error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }else{
                NetworkLayer.requestBrandProducts(brandID: collectionID ?? "") { products , error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }
        }else if (selectedSegment == 1){
            productType = "T-SHIRTS"
            if(collectionID == "272068509743"){
                NetworkLayer.requestAllProductsByProductType(productType: productType ?? "T-SHIRTS") { products , error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }else{
                NetworkLayer.requestCategoryProducts(collectionID: collectionID ?? "272069034031", productType: productType ?? "T-SHIRTS") { products, error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }
        }
        else if (selectedSegment == 2){
            productType = "SHOES"
            if(collectionID == "272068509743"){
                NetworkLayer.requestAllProductsByProductType(productType: productType ?? "SHOES") { products , error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }else{
                NetworkLayer.requestCategoryProducts(collectionID: collectionID ?? "272069034031", productType: productType ?? "SHOES") { products, error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }
        }
        else if (selectedSegment == 3){
            productType = "ACCESSORIES"
            if(collectionID == "272068509743"){
                NetworkLayer.requestAllProductsByProductType(productType: productType ?? "ACCESSORIES") { products , error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }else{
                NetworkLayer.requestCategoryProducts(collectionID: collectionID ?? "272069034031", productType: productType ?? "ACCESSORIES") { products, error in
                    self.arrayOfProducts = products
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }
        }
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfProducts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
        let product = arrayOfProducts![indexPath.row]
        cell.cellProduct = product
        
        if arrayOfWishedProducts.contains(where: { wishedProduct in
            wishedProduct.productId == product.productId
        }) {
            cell.wishlistBtn.isSelected = true
        }else{
            cell.wishlistBtn.isSelected = false
        }
        
        cell.setupCell(productImage: product.images![0].src!, productName: product.productName ?? "", productPrice: product.variants![0].price ?? "")
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.2, height: collectionView.frame.size.height/3.1)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedProduct = arrayOfProducts![indexPath.row]
        if arrayOfWishedProducts.contains(where: { wishedProduct in
            wishedProduct.productId == selectedProduct!.productId
        }) {
            isWished = true
        }else{
            isWished = false
        }
        performSegue(withIdentifier: "ProductDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductDetailsSegue"){
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            productDetailsVC.product = self.selectedProduct
            productDetailsVC.isWished = self.isWished
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
         UIView.animate(withDuration: 0.2) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha:1)
            }
        }
    }

     func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
         UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
