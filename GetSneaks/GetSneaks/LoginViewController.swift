//
//  LoginViewController.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/22/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var loginView: Login!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.themeMediumBlue
        loadViews()
        hideKeyboardWhenTappedAround(isActive: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignFirstResponder()
    }
    
    func loadViews() {
        loginView = Login()
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 0).isActive = true
        loginView.loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginView.signupButton.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
    }
    
    func animateSignupEntry(view: UIView) {
        UIView.animate(withDuration: 0.25, animations: {
            view.center.y = self.view.center.y
        }) { (success) in
        }
    }
    
    func createAlertWith(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil))
        return alert
    }
}


extension LoginViewController {
    
    func loginButtonAction() {
        guard let email = loginView.emailTextField.text else {return}
        guard let password = loginView.passwordTextField.text else {return}
        
        if email != "" && password != "" {
            FirebaseMethods.signInButton(email: email, password: password) { success in
                if success {
                    self.performSegue(withIdentifier: "landingSegue", sender: self)
                } else {
                    let alert = self.createAlertWith(title: "Couldn't Login", message: "Please Check Your Entries")
                    self.present(alert, animated: true, completion: {
                    })
                }
            }
        } else if email == "" && password != "" {
            let alert = self.createAlertWith(title: "Oops", message: "You need an email.")
            self.present(alert, animated: true, completion: {
            })
        } else if password == "" && email != "" {
            let alert = self.createAlertWith(title: "Oops", message: "You need a password.")
            self.present(alert, animated: true, completion: {
            })
        } else {
            let alert = self.createAlertWith(title: "Oops", message: "You need to enter some info.")
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    func signupButtonAction(_ sender: UIButton) {
        guard let email = loginView.emailTextField.text else {return}
        guard let password = loginView.passwordTextField.text else {return}
        guard let name = loginView.nameTextField.text else {return}
        
        if email != "" && password != "" && name != "" {
            if password.characters.count < 6 {
                let alert = self.createAlertWith(title: "Couldn't Signup", message: "Password must be at least 6 characters.")
                self.present(alert, animated: true, completion: {
                })
            } else {
                FirebaseMethods.signUpButton(email: email, password: password, name: name) { success in
                    if success {
                        self.performSegue(withIdentifier: "landingSegue", sender: self)
                    } else {
                        let alert = self.createAlertWith(title: "Couldn't Signup", message: "This email is already being used.")
                        self.present(alert, animated: true, completion: {
                        })
                    }
                }
            }
        } else {
            let alert = self.createAlertWith(title: "Oops", message: "Please fill in all the fields.")
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "landingSegue" {
            _ = segue.destination as! ChartViewController
        }
    }
    
    func forgotPasswordAction(_sender: UIButton) {
        let alertController = UIAlertController(title: "Enter E-Mail", message: "We'll send you a password reset e-mail", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Send", style: .default) { (action) in
            let emailField = alertController.textFields![0]
            if let email = emailField.text {
                FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
                    
                    // Handle error
                    if let error = error {
                        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    // Success
                    } else {
                        let alertController = UIAlertController(title: "Success", message: "Password reset e-mail sent", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter E-mail"
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
