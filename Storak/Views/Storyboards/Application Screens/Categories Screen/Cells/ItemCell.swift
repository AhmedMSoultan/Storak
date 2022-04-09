//
//  ItemCell.swift
//  Storak
//
//  Created by Mohamed Maged on 17/03/2022.
//

import UIKit
import Kingfisher
import FavoriteButton

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var wishlistBtn: FavoriteButton!
    
    var cellProduct : Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addShadowToProductCell()
    }

    func addShadowToProductCell() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 7
        self.layer.cornerRadius = 5
    }
    
    override var isSelected: Bool{
            didSet{
                UIView.animate(withDuration: 0.5) {
                    self.productImage.transform = self.isSelected ? CGAffineTransform(scaleX: 0.8, y: 0.8) : CGAffineTransform.identity
                }
            }
        }
    
    
    
    @IBAction func wishlistBtnAction(_ sender: Any) {
        var deletedIndex = 0
        if (wishlistBtn.isSelected){
            print("is selected")
            NotificationCenter.default.post(name: Notification.Name("addToWishlist"), object: cellProduct)
            localDataLayer.arrayOfWishedProducts.append(cellProduct!)
            localDataLayer.saveWishedProducts()
        }else{
            print("not selected")
            NotificationCenter.default.post(name: Notification.Name("removeFromWishlist"), object: cellProduct)
            localDataLayer.loadWishedProducts()
            
            if localDataLayer.arrayOfWishedProducts.contains(where: { wishedProduct in
                deletedIndex = localDataLayer.arrayOfWishedProducts.firstIndex(of: wishedProduct)!
                return wishedProduct.productId == cellProduct?.productId
            }) {
                localDataLayer.arrayOfWishedProducts.remove(at: deletedIndex)
                localDataLayer.saveWishedProducts()
            }
        }
    }
    
    
    func setupCell(productImage:URL , productName:String , productPrice:String){
        self.productNameLabel.text = productName
        self.productPriceLabel.text = productPrice + " LE"
        
        let url = productImage
        let processor = DownsamplingImageProcessor(size: self.productImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 8)
        self.productImage.kf.indicatorType = .activity
        
        self.productImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "clothes-placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}

