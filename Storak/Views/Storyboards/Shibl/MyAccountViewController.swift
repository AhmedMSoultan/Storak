//
//  MyAccountViewController.swift
//  Storak
//
//  Created by Mohamed Shibl on 11/03/2022.
//

import UIKit

class MyAccountViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var wishListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath)
        cell.textLabel?.text = ""
        return cell
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
