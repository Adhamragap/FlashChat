//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {


    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text,let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if error != nil {
                    self.makeAlert(title: "Oops", message: error!.localizedDescription)
                    return
                }else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    
                }
              
            }
        }
    }
    func makeAlert (title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
}
