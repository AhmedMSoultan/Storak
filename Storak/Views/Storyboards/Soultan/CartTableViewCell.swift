//
//  CartTableViewCell.swift
//  Storak
//
//  Created by Ahmed Soultan on 16/03/2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemTotalPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    var itemPrice = 0
    var initTotal = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    @IBAction func itemStepper(_ sender: UIStepper) {
//        itemQuantity.text = "\(Int(sender.value))"
//
//        let total = itemPrice * Int(sender.value)
//        itemTotalPrice.text = "\(total)" + " LE"
//    }
    
    @IBAction func plusBtnAction(_ sender: Any) {
        
        var quantity = Int(itemQuantity.text!)!
        quantity += 1
        itemQuantity.text = "\(quantity)"
        
        let total = itemPrice * quantity
        itemTotalPrice.text = "\(total)" + " LE"
        
        notify(newVal: itemPrice)
    }
    
    @IBAction func minusBtnAction(_ sender: Any) {
        var quantity = Int(itemQuantity.text!)!
        
        if(quantity > 1){
            quantity -= 1
            itemQuantity.text = "\(quantity)"
            
            let total = itemPrice * quantity
            itemTotalPrice.text = "\(total)" + " LE"
            
            notify(newVal: itemPrice * -1)
        }
    }
    
    
    
    func setUpCell(itemName:String , itemImage:String , itemPrice:String){
        self.itemNameLabel.text = itemName
        self.itemImage.image = UIImage(named: itemImage)
        self.itemPrice = Int(itemPrice)!
        self.itemTotalPrice.text = itemPrice + " LE"
        self.initTotal += self.itemPrice
        self.itemQuantity.text = "1"
    }
    
    func notify(newVal : Int){
                NotificationCenter.default.post(name: Notification.Name(changeTotalPriceNotification), object: newVal)
    }
}
