//
//  CreateAccount ViewController.swift
//  Friendship
//
//  Created by Ozgun Dogus on 2.04.2023.
//

import UIKit
import RealmSwift

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
           let realm = try! Realm()

    
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
      
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
