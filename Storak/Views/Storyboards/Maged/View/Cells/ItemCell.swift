//
//  ItemCell.swift
//  Storak
//
//  Created by Mohamed Maged on 17/03/2022.
//

import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
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
    
}
extension ItemCell {
    
    func configure() {
        
        productImage.image = UIImage(named: "Path544")
        
    }
    
}
