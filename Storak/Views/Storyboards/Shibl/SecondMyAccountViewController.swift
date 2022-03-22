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
    
    // MARK: Methods
    func getName(uid : String? ,completion: @escaping (_ name: String?) -> Void) {
        let docRef = Firestore.firestore().collection("users").document(uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!["firstname"]
                print("Document data: \(String(describing: dataDescription))")
                completion(dataDescription as? String)
            } else {
                print("Document does not exist")
                completion("")
            }

        }
    }
    
  
  
        
//        db.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print(" \(document.data())")
//                }
//            }
//        }
        
        
//
//        docRef.getDocument() { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
       // print(uid!)
        
//        Firestore.firestore().collection("users").document("uid").getDocument { (docSnapshot, error) in
//            if let doc = docSnapshot {
//                if let name = doc.get("firstname") as? String? {
//                    completion(name) // success; return name
//                } else {
//                    print("error getting field")
//                    completion(nil) // error getting field; return nil
//                }
//            } else {
//                if let error = error {
//                    print(error)
//                }
//                completion(nil) // error getting document; return nil
//            }
//        }
    }

