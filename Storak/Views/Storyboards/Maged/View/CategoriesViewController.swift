//
//  CategoriesViewController.swift
//  Storak
//
//  Created by Mohamed Maged on 11/03/2022.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
   private func configureTableView() {
        categoriesTableView.register(cellType: CategoryCell.self)
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: CategoryCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        switch (indexPath.row) {
        case 0:
            cell.categoryNameLabel.text = "Men"
            cell.categoryImageView.image = UIImage(named: "man")
        case 1:
            cell.categoryNameLabel.text = "Women"
            cell.categoryImageView.image = UIImage(named: "dress")
        case 2:
            cell.categoryNameLabel.text = "Kids"
            cell.categoryImageView.image = UIImage(named: "baby-clothes")
        default:
            cell.categoryNameLabel.text = "Sales"
            cell.categoryImageView.image = UIImage(named: "coupon")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
}
