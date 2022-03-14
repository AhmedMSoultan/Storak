//
//  SignUpViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fnameTF.useUnderline()
        lnameTF.useUnderline()
        emailTF.useUnderline()
        passwordTF.useUnderline()
    }
    

    @IBAction func signUp(_ sender: Any) {
        
    }
    
    @IBAction func returnToSignIn(_ sender: Any) {
        
    }
}
