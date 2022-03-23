//
//  ProductCollectionViewCell.swift
//  Storak
//
//  Created by Ahmed Nagy on 21/03/2022.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    
    func setupCell (productImage : URL){
        
        
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
