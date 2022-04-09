//
//  WishListViewController.swift
//  Storak
//
//  Created by Ahmed Soultan on 22/03/2022.
//

import UIKit

class WishListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    
    var arrayOfWishedProducts : [Product]?
    var numberOfProducts : Int!
    var selectedProduct : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        wishlistCollectionView.register(UINib(nibName: "ItemCell", bundle: .main), forCellWithReuseIdentifier: "itemCell")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(addItemToWishlist), name: Notification.Name("addToWishlist"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(removeItemFromWishlist), name: Notification.Name("removeFromWishlist"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localDataLayer.loadWishedProducts()
        self.arrayOfWishedProducts = localDataLayer.arrayOfWishedProducts
        self.wishlistCollectionView.reloadData()
    }
    
    // MARK: - Observer Methods
    @objc func addItemToWishlist(_ notification : Notification){
        if let product = notification.object as? Product{
            arrayOfWishedProducts?.append(product)
            localDataLayer.arrayOfWishedProducts = self.arrayOfWishedProducts!
            localDataLayer.saveWishedProducts()
            self.wishlistCollectionView.reloadData()
        }
    }
    
    @objc func removeItemFromWishlist(_ notification : Notification){
        if let product = notification.object as? Product {
            let index = (arrayOfWishedProducts?.firstIndex(of: product))!
            arrayOfWishedProducts?.remove(at: index)
            localDataLayer.arrayOfWishedProducts = self.arrayOfWishedProducts!
            localDataLayer.saveWishedProducts()
            self.wishlistCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductDetailsSegue"){
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            productDetailsVC.product = selectedProduct
            productDetailsVC.isWished = true
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfWishedProducts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
        let product = arrayOfWishedProducts![indexPath.row]
        cell.cellProduct = product
        cell.wishlistBtn.isSelected = true
        cell.setupCell(productImage: product.images![0].src!, productName: product.productName ?? "", productPrice: product.variants![0].price ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = arrayOfWishedProducts![indexPath.row]
        performSegue(withIdentifier: "ProductDetailsSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.2 , height: collectionView.frame.size.height / 3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
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

}
