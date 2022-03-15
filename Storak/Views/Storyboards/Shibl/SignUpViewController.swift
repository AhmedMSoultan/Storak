//
//  SignUpViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit
import Firebase

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
        guard let name = fnameTF.text else {return}
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { user, err in
            if err != nil {
                print(err?.localizedDescription)
            }else{
                print("creation is done")
                let alert = UIAlertController(title: " Hi \(name) ", message: "You Are regesterd successfuly", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
        
    
    
    @IBAction func returnToSignIn(_ sender: Any) {
        let signinVC = (storyboard?.instantiateViewController(withIdentifier: "signinVC")) as! LogInViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
}
