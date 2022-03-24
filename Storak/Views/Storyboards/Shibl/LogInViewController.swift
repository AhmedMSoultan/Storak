
//
//  LogInViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore

class LogInViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    var user : User?

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.useUnderline()
        passwordTF.useUnderline()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener { _, user in
          guard let user = user else { return }
            self.user? = user
        }}
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    
   
    @IBAction func signIN(_ sender: Any) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in:
             .whitespacesAndNewlines)

        Auth.auth().signIn(withEmail: email, password: password) { user, error in
          if let error = error, user == nil {
            let alert = UIAlertController(
              title: "Sign In Failed",
              message: error.localizedDescription,
              preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
          }
            else{
                self.user = user?.user
                print(self.user!.uid)
                //print("succed")
                self.emailTF.text = ""
                self.passwordTF.text = ""
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInMyAccountViewController") as! LoggedInMyAccountViewController
                secondVC.uid = self.user!.uid
                self.navigationController?.pushViewController(secondVC, animated: true)
                
                }
          }
    }
       
    @IBAction func goTosignUp(_ sender: Any) {
        let signupVC = (storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")) as! SignUpViewController
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    }

/// Extensions
extension UITextField {
 func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIImageView {
   func fetchImageFromUrl(_ url: String) {
       guard let url = URL(string: url) else { return }
       let task = URLSession.shared.dataTask(with: url) { data, _, _ in
           guard let data = data else { return }
           DispatchQueue.main.async {
               self.image = UIImage(data: data)
           }
       }
       task.resume()
   }
}
