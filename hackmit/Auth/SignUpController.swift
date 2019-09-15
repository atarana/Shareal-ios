//
//  SignUpController.swift
//  hackmit
//
//  Created by Kunal Sahni on 14/09/2019.
//  Copyright © 2019 Kunal Sahni. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var psw: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Signup")
        signUp.layer.cornerRadius = 10
        signUp.clipsToBounds = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            textField.resignFirstResponder()
            email.becomeFirstResponder()
        } else if textField == psw {
            textField.resignFirstResponder()
            psw.becomeFirstResponder()
        } else if textField == name {
            textField.resignFirstResponder()
            name.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            performSignUp(self)
        }
        return true
    }
    
    @IBAction func performSignUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: psw.text!) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                let alertController = UIAlertController(title: "Error", message:
                    error?.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            print("\(user.email!) created")
            self.performSegue(withIdentifier: "homeSegue2", sender: nil)
            // [END_EXCLUDE]
        }
    }
}
