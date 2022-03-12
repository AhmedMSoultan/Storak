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
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // addShadowToCategoryImageView()
        configure()
    }

    func addShadowToCategoryImageView() {
        categoryImageView.layer.shadowColor = UIColor.black.cgColor
        categoryImageView.layer.shadowOpacity = 1
        categoryImageView.layer.shadowOffset = .zero
        categoryImageView.layer.shadowRadius = 10
    }
  
    
}

extension CategoryCell {
    
    func configure() {
        
        categoryImageView.image = UIImage(named: "Path544")
        
    }
    
}
