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
            cell.productImage.image = UIImage(named: "Path544")
        default:
            cell.productImage.image = UIImage(named: "Path541")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/2.5, height: collectionView.frame.size.height/3.3)
    }
}
