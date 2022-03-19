//
//  ProductsViewController.swift
//  Storak
//
//  Created by Mohamed Maged on 17/03/2022.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var selectedSegment: Int!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var productsCollectionView: UICollectionView!
  
    @IBAction func switchSelectedSegment(_ sender: UISegmentedControl) {
        selectedSegment = sender.selectedSegmentIndex
        productsCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedSegment = 0
        productsCollectionView.register(cellType: ItemCell.self)
        
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: ItemCell.self, for: indexPath)
        
        switch selectedSegment {
        case 0:
            cell.productImage.image = UIImage(named: "Chair1")
        case 1:
            cell.productImage.image = UIImage(named: "Chair2")
        case 2:
            cell.productImage.image = UIImage(named: "Chair3")
        default:
            cell.productImage.image = UIImage(named: "Chair4")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/2.2, height: collectionView.frame.size.height/3.1)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
     func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha:1)
            }
        }
    }

     func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
