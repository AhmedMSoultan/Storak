//
//  MyAccountViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit

class MyAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func ToSignInVC(_ sender: Any) {
        let signinVC = (storyboard?.instantiateViewController(withIdentifier: "signinVC")) as! LogInViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
    
    @IBAction func ToSignUpVC(_ sender: Any) {
        let signupVC = (storyboard?.instantiateViewController(withIdentifier: "signupVC")) as! SignUpViewController
        navigationController?.pushViewController(signupVC, animated: true)
        
    }
    
}
