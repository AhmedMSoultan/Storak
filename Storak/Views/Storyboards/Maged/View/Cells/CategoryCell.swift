//
//  CategoryCell.swift
//  Storak
//
//  Created by Mohamed Maged on 12/03/2022.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var numberOfCategoryItemsLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToCategoryImageView()
        configure()
    }

    func addShadowToCategoryImageView() {
        imageContainer.layer.shadowColor = UIColor.gray.cgColor
        imageContainer.layer.shadowOpacity = 1
        imageContainer.layer.shadowOffset = .zero
        imageContainer.layer.shadowRadius = 10
    }
  
    
}

extension CategoryCell {
    
    func configure() {
        
        categoryImageView.image = UIImage(named: "Path544")
        
    }
    
}
