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
                UIView.animate(withDuration: 0.05) {
                    self.brandImage.transform = self.isSelected ? CGAffineTransform(scaleX: 0.8, y: 0.8) : CGAffineTransform.identity
                }
            }
        }
    
    
    
    func setUpCell(brandImage:URL , brandName:String){
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
