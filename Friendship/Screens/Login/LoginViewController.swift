//
//  LoginViewController.swift
//  Friendship
//
//  Created by Ozgun Dogus on 2.04.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let username = usernameTextField.text,let password = passwordTextField.text
        else{
            return
        }
        if let _ = UserInfo.information.first(where: { $0.0 == username && $0.1 == password }){
//            performSegue(withIdentifier: "homePage", sender: nil)
        } else{
            let alert = UIAlertController(title: "Hata", message: "Kullanıcı adı veya şifre hatalı", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alert.addAction(okAction)
                   present(alert, animated: true, completion: nil)
        }
        
    }
    
    

}
