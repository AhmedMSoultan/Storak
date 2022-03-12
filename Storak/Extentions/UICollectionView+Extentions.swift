//
//  UICollectionView+Extentions.swift
//  Storak
//
//  Created by Mohamed Maged on 12/03/2022.
//

import UIKit


public extension UICollectionView {
 
    func register(cellType types: UICollectionViewCell.Type...) {
        types.forEach { type in
            let name = String(describing: type)
            let bundle = Bundle(for: type)
            if bundle.path(forResource: name, ofType: "nib") != nil {
                register(UINib(nibName: name, bundle: bundle), forCellWithReuseIdentifier: name)
            } else {
                register(type, forCellWithReuseIdentifier: name)
            }
        }
    }
 
    func dequeueReusableCell<T: UICollectionViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
 
    func register<T: UICollectionReusableView>(supplementaryViewType type: T.Type, kind: UICollectionReusableView.Kind) {
        let name = String(describing: type)
        let bundle = Bundle(for: type)
        if bundle.path(forResource: name, ofType: "nib") != nil {
            register(UINib(nibName: name, bundle: bundle), forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: name)
        } else {
            register(type, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: name)
        }
    }
 
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(withType type: T.Type, andKind kind: UICollectionReusableView.Kind, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
 
 
}
