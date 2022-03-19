//
//  CategoriesCollectionViewCell.swift
//  Storak
//
//  Created by Ahmed Soultan on 15/03/2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(categoryName:String , categoryImg:String ){
        self.categoryName.text = categoryName
        self.categoryImg.image = UIImage(named: categoryImg)
    }

}
