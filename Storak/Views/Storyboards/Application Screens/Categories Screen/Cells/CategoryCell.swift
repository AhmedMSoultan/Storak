//
//  CategoryCell.swift
//  Storak
//
//  Created by Mohamed Maged on 12/03/2022.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToCategoryImageView()
    }

    func addShadowToCategoryImageView() {
        imageContainer.layer.backgroundColor = UIColor.white.cgColor
        imageContainer.layer.shadowColor = UIColor.black.cgColor
        imageContainer.layer.shadowOpacity = 0.1
        imageContainer.layer.masksToBounds = false
        imageContainer.layer.shadowOffset = .zero
        imageContainer.layer.shadowRadius = 7
        imageContainer.layer.cornerRadius = 5
    }
  
    func setupCell(categoryName : String , categoryImage : String) {
        
        categoryNameLabel.text = categoryName
        categoryImageView.image = UIImage(named: categoryImage
        )
    }
}

