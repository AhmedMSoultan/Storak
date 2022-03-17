//
//  ProductsViewController.swift
//  Storak
//
//  Created by Mohamed Maged on 17/03/2022.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBAction func segmentedDidChanged(_ sender: Any) {
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollectionView.register(cellType: ItemCell.self)
        
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: ItemCell.self, for: indexPath)
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 7
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        return CGSize(width: 200, height: 200)
        return CGSize(width: collectionView.frame.size.width/2.5, height: collectionView.frame.size.height/3.3)
    }
}
