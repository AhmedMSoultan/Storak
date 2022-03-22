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
           // print(self.user?.uid)
            
        }
//        getName { (name) in
//                    if let name = name {
//                        self.emailTF.text = name
//                        print("great success")
//                    }
//                }
    }
    
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
                print("succed")
              //  self.emailTF.text = ""
                //self.passwordTF.text = ""
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "accVC") as! SecondMyAccountViewController
                secondVC.uid = self.user!.uid
                self.navigationController?.pushViewController(secondVC, animated: true)
                
                }
          }
//        let db = Firestore.firestore()
//        // Read the documents at a specific path
//        db.collection("users").getDocuments { snapshot, error in
//           // Check for errors
//            if (error != nil) nil {
//                   // No errors
//                  if let snapshot = snapshot {
//                        // Get all the documents and create Todos
//                          snapshot.documents.map { d in
//                               return user(id: d.documentID,
//                                                firstName: d["firstname"] as? String ?? "")
//                                           }}
           
    }
        
        
    
    

        
//    func getName(completion: @escaping (_ name: String?) -> Void) {
//            guard let uid = Auth.auth().currentUser?.uid else { // safely unwrap the uid; avoid force unwrapping with !
//                completion(nil) // user is not logged in; return nil
//                return
//            }
//            Firestore.firestore().collection("users").document(uid).getDocument { (docSnapshot, error) in
//                if let doc = docSnapshot {
//                    if let name = doc.get("firstName") as? String {
//                        print(name)
//                        completion(name) // success; return name
//                    } else {
//                        print("error getting field")
//                        completion(nil) // error getting field; return nil
//                    }
//                } else {
//                    if let error = error {
//                        print(error)
//                    }
//                    completion(nil) // error getting document; return nil
//                }
//            }
//        }
        
    
    
    @IBAction func goTosignUp(_ sender: Any) {
        let accVC = (storyboard?.instantiateViewController(withIdentifier: "accVC")) as! SecondMyAccountViewController
        navigationController?.pushViewController(accVC, animated: true)
//
//        let signupVC = (storyboard?.instantiateViewController(withIdentifier: "signupVC")) as! SignUpViewController
//        navigationController?.pushViewController(signupVC, animated: true)
//    }
    
    }}
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


//                    .document("data")
//                usersRef.getDocument { (document,err) in
//                    if let document = document, document.exists {
//                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data: \(dataDescription)")
//                    } else {
//                        print("Document does not exist")
//                    }



//        Auth.auth().signIn(withEmail: email, password: password) {
//            (user, err) in
//           if err != nil {
//               // Couldn't sign in
//               print("error is : \(String(describing: err?.localizedDescription))")
//           }else {
//               print("sign in succses")
//
//           }
