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
    var arrayOfCartItems = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartItemsTableView.delegate = self
        cartItemsTableView.dataSource = self
        cartItemsTableView.register(UINib(nibName: "CartTableViewCell", bundle: .main), forCellReuseIdentifier: "CartItemCell")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTotalPrice), name:Notification.Name(changeTotalPriceNotification), object: nil)
        
        
        
        
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
        
        updateScreen()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "paymentSegue"){
            let paymentCardVC = segue.destination as! PaymentCardViewController
            paymentCardVC.orderTotal = subtotalPriceLabel.text ?? ""
        }
    }
    
    func updateScreen() {
        localDataLayer.loadCartProducts()
        arrayOfCartItems = localDataLayer.arrayOfCartProducts
        cartItemsTableView.reloadData()
        
        for item in arrayOfCartItems {
            print(item.variants![0].price!)
            let priceValue = Double (item.variants![0].price!)!
            print(priceValue)
            initTotal += Int(priceValue)
        }
        subtotalPriceLabel.text = "\(initTotal)"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension CartViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItemCell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartTableViewCell
        let item = arrayOfCartItems[indexPath.row]
        cartItemCell.setUpCell(itemName: item.productName!, itemImageURL: item.images![0].src!, itemPrice: item.variants![0].price!)
        cartItemCell.selectionStyle = .none
        return cartItemCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let cartItem = arrayOfCartItems[indexPath.row]
            let index = localDataLayer.arrayOfCartProducts.firstIndex(of: cartItem)!
            localDataLayer.arrayOfCartProducts.remove(at: index)
            localDataLayer.saveCartProducts()
            self.arrayOfCartItems.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateScreen()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
