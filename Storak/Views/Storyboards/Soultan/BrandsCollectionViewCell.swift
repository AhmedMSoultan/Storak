//
//  BrandsCollectionViewCell.swift
//  Storak
//
//  Created by Ahmed Soultan on 16/03/2022.
//

import UIKit
import Kingfisher

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(brandImage:URL , brandName:String){
//        self.brandImage.image = UIImage(named: brandImage)
        self.brandName.text = brandName
        
        
        let url = brandImage
        let processor = DownsamplingImageProcessor(size: self.brandImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 8)
        self.brandImage.kf.indicatorType = .activity
        self.brandImage.kf.setImage(
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
