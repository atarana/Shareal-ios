//
//  LoginController.swift
//  hackmit
//
//  Created by Kunal Sahni on 14/09/2019.
//  Copyright © 2019 Kunal Sahni. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var psw: UITextField!
    @IBOutlet weak var login: UIButton!
    var handle: AuthStateDidChangeListenerHandle?

    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            print("Login redirecting to home")
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
            // [END_EXCLUDE]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login")
        email.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        login.layer.cornerRadius = 10
        login.clipsToBounds = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            textField.resignFirstResponder()
            email.becomeFirstResponder()
        } else if textField == psw {
            textField.resignFirstResponder()
            psw.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            performLogin(self)
        }
        return true
    }
    @IBAction func performLogin(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: psw.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if let error = error {
                let alertController = UIAlertController(title: "Error", message:
                    error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self!.present(alertController, animated: true, completion: nil)
                return
            }
            self!.performSegue(withIdentifier: "homeSegue", sender: nil)
        }
    }
}
