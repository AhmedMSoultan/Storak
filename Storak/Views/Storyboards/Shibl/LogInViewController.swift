//
//  LogInViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class LogInViewController: UIViewController {

    
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.useUnderline()
        passwordTF.useUnderline()

    }
    
   
    @IBAction func signIN(_ sender: Any) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in:
             .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, err) in
           if err != nil {
               // Couldn't sign in
               print("error is : \(String(describing: err?.localizedDescription))")
           }else {
               print("sign in succses")
           }
            self.emailTF.text = ""
            self.passwordTF.text = ""
        }
        
    }
    @IBAction func goTosignUp(_ sender: Any) {
        let signupVC = (storyboard?.instantiateViewController(withIdentifier: "signupVC")) as! SignUpViewController
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}
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
