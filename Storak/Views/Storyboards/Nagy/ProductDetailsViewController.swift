//
//  ProductDetailsViewController.swift
//  Storak
//
//  Created by Ahmed Nagy on 21/03/2022.
//

import UIKit
import FavoriteButton

let cellIdentifier = "ProductCell"


class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var productDetailsTextView: UITextView!
    @IBOutlet weak var productVendorLabel: UILabel!
    @IBOutlet weak var productColorLabel: UILabel!
    @IBOutlet weak var productInventoryQuantityLabel: UILabel!
    
    @IBOutlet weak var addToWishedBtn: FavoriteButton!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var product : Product?
    
    var timer: Timer?
    var currentCellIndex = 0
    
    var isWished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = product?.images?.count ?? 0
        addToCartButton.layer.cornerRadius = 8
        
        if (isWished == true){
            addToWishedBtn.isSelected = true
        }
        
        startTimer()
        self.setupScreen()
    }
    
    
    @IBAction func cartBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "cartScreen", sender: self)
    }
    
    
    @IBAction func addToCartButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.addToCartButton.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.addToCartButton.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        
        localDataLayer.arrayOfCartProducts.append(product!)
        localDataLayer.saveCartProducts()
    }
    
    @IBAction func addToWishlistBtnAction(_ sender: Any) {
        var deletedIndex = 0
        if (addToWishedBtn.isSelected){
            print("is selected")
            localDataLayer.arrayOfWishedProducts.append(product!)
            localDataLayer.saveWishedProducts()
        }else{
            print("not selected")
            localDataLayer.loadWishedProducts()
            
            if localDataLayer.arrayOfWishedProducts.contains(where: { wishedProduct in
                deletedIndex = localDataLayer.arrayOfWishedProducts.firstIndex(of: wishedProduct)!
                return wishedProduct.productId == product?.productId
            }) {
                localDataLayer.arrayOfWishedProducts.remove(at: deletedIndex)
                localDataLayer.saveWishedProducts()
            }
        }
        
    }
    
    
    @IBAction func quantityStepperAction(_ sender: Any) {
        let stepperValue = (Int(stepper.value))
        productQuantity.text = "\(stepperValue)"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.2, target: self, selector: #selector(swipeProductImage), userInfo: nil, repeats: true)
    }
    
    @objc func swipeProductImage() {
        if currentCellIndex < (product?.images?.count)! - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
      
    }
    
    func setupScreen(){
        productName.text = product?.productName
        productPrice.text = (product?.variants?[0].price)! + " LE"
        productQuantity.text = "1"
        productDetailsTextView.text = product?.productDescription
        productVendorLabel.text = product?.productVendor
        productColorLabel.text = product?.variants![0].option2
        productInventoryQuantityLabel.text = "\(String(describing: (product?.variants![0].inventory_quantity!)!))"
        stepper.minimumValue = 1
        stepper.maximumValue = Double((product?.variants![0].inventory_quantity!)!)
    }
    
}


extension ProductDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.setupCell(productImage: (product?.images?[indexPath.row].src!)!)
        return cell
    }
}

extension ProductDetailsViewController: UICollectionViewDelegate {
    
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

