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

class SecondMyAccountViewController: UIViewController {
  
    

    var uid : String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var firstNameLabel: UILabel!
//
//    let id = Auth.auth().currentUser!.uid
//    let email = Auth.auth().currentUser!.email
    
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
            print("you sign out succesfuly")
            let myaccount = self.storyboard?.instantiateViewController(withIdentifier: "myaccount") as! MyAccountViewController
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
               // print("Document data: \(String(describing: dataDescription))")
                completion(dataDescription as? String)
            } else {
                print("Document does not exist")
                completion("in our shop")
            }

        }
    }
    }

