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
        // Initialization code
    }

//    func addShadowToProductCell() {
//        ItemCell.layer.backgroundColor = UIColor.white.cgColor
//        ItemCell.layer.shadowColor = UIColor.black.cgColor
//        ItemCell.layer.shadowOpacity = 0.1
//        ItemCell.layer.masksToBounds = false
//        ItemCell.layer.shadowOffset = .zero
//        ItemCell.layer.shadowRadius = 7
//        ItemCell.layer.cornerRadius = 5
//    }
    
}
