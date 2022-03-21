//
//  ProductDetailsViewController.swift
//  Storak
//
//  Created by Ahmed Nagy on 21/03/2022.
//

import UIKit

let cellIdentifier = "ProductCell"


class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var addToCartButton: UIButton!
    let data = [
        UIImage(named: "Banner3"),
        UIImage(named: "Banner1"),
        UIImage(named: "Banner3"),
        UIImage(named: "Banner1"),
        UIImage(named: "Banner3"),
        UIImage(named: "Banner1"),
        UIImage(named: "Banner3")
    ]
    
    var timer: Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = data.count
        addToCartButton.layer.cornerRadius = 8
        
        startTimer()
    }
    
    @IBAction func addToCartButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.addToCartButton.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.addToCartButton.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.2, target: self, selector: #selector(swipeProductImage), userInfo: nil, repeats: true)
    }
    
    @objc func swipeProductImage() {
        if currentCellIndex < data.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
      
    }
    
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.productImage.image = data[indexPath.row]
        return cell
    }
    
    
}

extension ProductDetailsViewController: UICollectionViewDelegate {
    
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

