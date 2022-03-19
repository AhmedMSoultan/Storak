//
//  BrandsCollectionViewCell.swift
//  Storak
//
//  Created by Ahmed Soultan on 16/03/2022.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(brandImage:String , brandName:String){
        self.brandImage.image = UIImage(named: brandImage)
        self.brandName.text = brandName
    }
}
