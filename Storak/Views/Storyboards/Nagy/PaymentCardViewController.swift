//
//  PaymentCardViewController.swift
//  Storak
//
//  Created by Ahmed Nagy on 21/03/2022.
//

import UIKit

class PaymentCardViewController: UIViewController {

    @IBOutlet weak var cvvCodeTextField: UITextField!
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardTextField.useUnderline()
        cardHolderNameTextField.useUnderline()
        cvvCodeTextField.useUnderline()
        saveButton.layer.cornerRadius = 8
        
        //  Will only execute if the system is having iOS 14 or greater
        if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .compact
            }

    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.saveButton.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.saveButton.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
    }
    

}

