

//
//  SecondMyAccountViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 20/03/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore

class LoggedInMyAccountViewController: UIViewController{
   
     
   @IBOutlet weak var firstNameLabel: UILabel!
    
    var uid : String?
    
     override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // call super
        
        getName(uid: uid) { name in
            self.firstNameLabel.text = name!
            print(name!)
        }
    }
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("You Signed out successfully")
            let myaccount = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
            self.navigationController?.pushViewController(myaccount, animated: true)
            
        }catch let err{
            print(err)
        }
    }
    
    func getName(uid : String? ,completion: @escaping (_ name: String?) -> Void) {
        let docRef = Firestore.firestore().collection("users").document(uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!["firstname"]
                completion(dataDescription as? String)
            } else {
                print("Document does not exist")
                completion("in our shop")
            }

            }
        }
    }
