//
//  SignUpViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit
import Firebase
import FirebaseFirestore


class SignUpViewController: UIViewController {
    
//    var ref: DatabaseReference!
//
//     ref = Database.database().reference()
//
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTF()
    }
   

    @IBAction func signUp(_ sender: Any) {
//        guard let name = fnameTF.text else {return}
//        guard let email = emailTF.text else {return}
//        guard let password = passwordTF.text else {return}
        // check if text feild is empty
        let firstName = fnameTF.text!.trimmingCharacters (in:.whitespacesAndNewlines)
        let lastName = lnameTF.text!.trimmingCharacters(in:.whitespacesAndNewlines)
        let email = emailTF.text!.trimmingCharacters(in:.whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in:.whitespacesAndNewlines)
        /// create yser in firebase
        Auth.auth().createUser(withEmail: email, password: password) { user, err in
            if err != nil {
                print("error is : \(String(describing: err?.localizedDescription))")
                self.clearTF()
            }else{
                // save f&l name in database fire store
                let db = Firestore.firestore()
                db.collection("users").document(user!.user.uid).setData(["firstname": firstName,"lastname":lastName, "uid": user!.user.uid])
                if err != nil {
                       // Show error message
                        print("Error saving user data")
                }else{
                print("creation is done")
                // alert for succses of registeration
                let alert = UIAlertController(title: " Hi \(firstName) ", message: "You Are regesterd successfuly", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.clearTF()
                }
            }
        }
    }
        
    
    
    @IBAction func returnToSignIn(_ sender: Any) {
        let signinVC = (storyboard?.instantiateViewController(withIdentifier: "signinVC")) as! LogInViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
    // to clear text feilds
    func clearTF(){
        self.emailTF.text = ""
        self.passwordTF.text = ""
        self.lnameTF.text = ""
        self.fnameTF.text = ""
    }
    func styleTF(){
        fnameTF.useUnderline()
        lnameTF.useUnderline()
        emailTF.useUnderline()
        passwordTF.useUnderline()
}
}
