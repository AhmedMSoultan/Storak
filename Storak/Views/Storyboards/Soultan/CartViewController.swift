//
//  CartViewController.swift
//  Storak
//
//  Created by Ahmed Soultan on 16/03/2022.
//

import UIKit

let changeTotalPriceNotification = "com.storak.changeTotalPrice"

class CartViewController: UIViewController {

    @IBOutlet weak var cartItemsTableView: UITableView!
    @IBOutlet weak var subtotalPriceLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var checkoutBtn: UIButton!
    
    var totalPrice : Int = 0 {
        didSet{
            subtotalPriceLabel.text = "\(totalPrice)" + " LE"
        }
    }
    
    var initTotal  = 0
    
    let arrayOfItems = [item(itemName: "baby-clothes", itemImage: "baby-clothes", itemPrice: "100", itemCategory: "Furniture"),
                        item(itemName: "man", itemImage: "man", itemPrice: "80", itemCategory: "Furniture"),
                        item(itemName: "onesie", itemImage: "onesie", itemPrice: "130", itemCategory: "Furniture"),
                        item(itemName: "sneakers", itemImage: "sneakers", itemPrice: "100", itemCategory: "Furniture"),
                        item(itemName: "tshirt", itemImage: "tshirt", itemPrice: "180", itemCategory: "Furniture"),
                        item(itemName: "wardrobe", itemImage: "wardrobe", itemPrice: "100", itemCategory: "Furniture"),
                        item(itemName: "sunglasses", itemImage: "sunglasses", itemPrice: "80", itemCategory: "Furniture"),
                        item(itemName: "onesie", itemImage: "onesie", itemPrice: "130", itemCategory: "Furniture"),
                        item(itemName: "sneakers", itemImage: "sneakers", itemPrice: "100", itemCategory: "Furniture"),
                        item(itemName: "baby-clothes", itemImage: "baby-clothes", itemPrice: "180", itemCategory: "Furniture")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartItemsTableView.delegate = self
        cartItemsTableView.dataSource = self
        cartItemsTableView.register(UINib(nibName: "CartTableViewCell", bundle: .main), forCellReuseIdentifier: "CartItemCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTotalPrice), name:Notification.Name(changeTotalPriceNotification), object: nil)
        
        
        for item in arrayOfItems {
            initTotal += Int(item.itemPrice) ?? 0
        }
        subtotalPriceLabel.text = "\(initTotal)"
        
    }
    
    @objc func changeTotalPrice(notification: Notification){
        
        if let newTotalPrice = notification.object as? Int {
            var oldTotal = Int(subtotalPriceLabel.text!)!
            oldTotal  += newTotalPrice
            subtotalPriceLabel.text = "\(String(describing: oldTotal))"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        bottomView.layoutIfNeeded()
        let path = UIBezierPath(roundedRect:bottomView.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        bottomView.layer.mask = maskLayer
        
    }
    
    
    @IBAction func checkoutBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.6, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.checkoutBtn.transform =
                   CGAffineTransform(scaleX: 2.5, y: 2.5)
                self.checkoutBtn.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        
        performSegue(withIdentifier: "paymentSegue", sender: self)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension CartViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItemCell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartTableViewCell
        let item = arrayOfItems[indexPath.row]
        cartItemCell.setUpCell(itemName: item.itemName, itemImage: item.itemImage, itemPrice: item.itemPrice)
        cartItemCell.selectionStyle = .none
        return cartItemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
