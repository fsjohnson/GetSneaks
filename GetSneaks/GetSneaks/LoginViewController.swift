//
//  LoginViewController.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/22/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import Firebase

struct LoginViewPosition {
    
    static let emailPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.30)
    static let passwordPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.40)
    static let namePosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.40)
    
    static let loginPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.55)
    static let forgotPasswordPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.60)
    static let newuserPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.95)
    static let signupPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.65)
    static let cancelPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.65)
}

struct NewUserViewPosition {
    
    static let emailPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.20)
    static let passwordPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.28)
    static let namePosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.36)
    
    static let loginPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.55)
    static let newuserPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.55)
    static let signupPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.55)
    static let cancelPosition = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.65)
}

class LoginViewController: UIViewController {
    
    var emailTextField: CustomTextField = CustomTextField()
    var passwordTextField: CustomTextField = CustomTextField()
    var nameTextField: CustomTextField = CustomTextField()
    
    var loginButton: UIButton!
    var newuserButton: UIButton!
    var signupButton: UIButton!
    var cancelButton: UIButton!
    
    var logoImage: UIImageView!
    var forgotPasswordButton: UIButton!
    
    var signupButtonState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.themeMediumBlue
        loadViews()
        setPositions()
        emailTextField.becomeFirstResponder()
        hideKeyboardWhenTappedAround(isActive: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignFirstResponder()
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
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
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
    
    func newuserButtonAction(_ sender: UIButton) {
        animateForSignup()
    }
    
    func signupButtonAction(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let name = nameTextField.text else {return}
        
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
    
    
    func cancelButtonAction(_ sender: UIButton) {
        animateForLogin()
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


//MARK: -Animations
extension LoginViewController {
    
    fileprivate func animateForSignup() {
        self.nameTextField.isHidden = false
        self.signupButton.isHidden = false
        self.cancelButton.isHidden = false
        self.forgotPasswordButton.isHidden = true
        self.newuserButton.isUserInteractionEnabled = false
        self.cancelButton.isUserInteractionEnabled = false
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                self.emailTextField.center = NewUserViewPosition.emailPosition
                self.passwordTextField.center = NewUserViewPosition.passwordPosition
                self.nameTextField.center = NewUserViewPosition.namePosition

                self.loginButton.center = NewUserViewPosition.loginPosition
                self.newuserButton.center = NewUserViewPosition.newuserPosition
                self.signupButton.center = NewUserViewPosition.signupPosition
                self.cancelButton.center = NewUserViewPosition.cancelPosition
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.emailTextField.transform = CGAffineTransform.init(scaleX: 1.1, y: 1)
                self.passwordTextField.transform = CGAffineTransform.init(scaleX: 1.1, y: 1)
                self.nameTextField.transform = CGAffineTransform.init(scaleX: 1.2, y: 1)

                self.loginButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1)
                self.newuserButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1)
                self.signupButton.transform = CGAffineTransform.init(scaleX: 1.2, y: 1)
                self.cancelButton.transform = CGAffineTransform.init(scaleX: 1.2, y: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                self.emailTextField.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
                self.passwordTextField.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
                self.nameTextField.transform = CGAffineTransform.init(scaleX: 0.8, y: 1)

                self.loginButton.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
                self.newuserButton.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
                self.signupButton.transform = CGAffineTransform.init(scaleX: 0.8, y: 1)
                self.cancelButton.transform = CGAffineTransform.init(scaleX: 0.8, y: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                self.emailTextField.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.passwordTextField.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.nameTextField.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                
                self.loginButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.newuserButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.signupButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.cancelButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        }) { (success) in
            self.loginButton.isHidden = true
            self.newuserButton.isHidden = true
            self.newuserButton.isUserInteractionEnabled = true
            self.cancelButton.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func animateForLogin() {
        self.loginButton.isHidden = false
        self.newuserButton.isHidden = false
        self.newuserButton.isUserInteractionEnabled = false
        self.cancelButton.isUserInteractionEnabled = false
        self.forgotPasswordButton.isHidden = false
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                self.emailTextField.center = LoginViewPosition.emailPosition
                self.passwordTextField.center = LoginViewPosition.passwordPosition
                self.nameTextField.center = LoginViewPosition.namePosition
                
                self.loginButton.center = LoginViewPosition.loginPosition
                self.newuserButton.center = LoginViewPosition.newuserPosition
                self.signupButton.center = LoginViewPosition.signupPosition
                self.cancelButton.center = LoginViewPosition.cancelPosition
                self.forgotPasswordButton.center = LoginViewPosition.forgotPasswordPosition
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.emailTextField.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
                self.passwordTextField.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
                self.nameTextField.transform = CGAffineTransform.init(scaleX: 0.8, y: 1)
                
                self.loginButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.newuserButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.signupButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.cancelButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                self.emailTextField.transform = CGAffineTransform.init(scaleX: 1.1, y: 1)
                self.passwordTextField.transform = CGAffineTransform.init(scaleX: 1.1, y: 1)
                self.nameTextField.transform = CGAffineTransform.init(scaleX: 1.2, y: 1)
                
                self.loginButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.newuserButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.signupButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.cancelButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                self.emailTextField.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.passwordTextField.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.nameTextField.transform = CGAffineTransform.init(scaleX: 0, y: 1)
                
                self.loginButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.newuserButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.signupButton.transform = CGAffineTransform.init(scaleX: 0, y: 1)
                self.cancelButton.transform = CGAffineTransform.init(scaleX: 0, y: 1)
            })
        }) { (success) in
            self.nameTextField.isHidden = true
            self.signupButton.isHidden = true
            self.cancelButton.isHidden = true
            self.newuserButton.isUserInteractionEnabled = true
            self.cancelButton.isUserInteractionEnabled = true
        }
    }
}


//MARK: -Setup buttons
extension LoginViewController {
    fileprivate func setPositions() {
        emailTextField.center = LoginViewPosition.emailPosition
        passwordTextField.center = LoginViewPosition.passwordPosition
        nameTextField.center = LoginViewPosition.namePosition
        forgotPasswordButton.center = LoginViewPosition.forgotPasswordPosition
        
        nameTextField.transform = CGAffineTransform.init(scaleX: 0.0, y: 1)
        nameTextField.isHidden = true
        
        loginButton.center = LoginViewPosition.loginPosition
        newuserButton.center = LoginViewPosition.newuserPosition
        signupButton.center = LoginViewPosition.signupPosition
        cancelButton.center = LoginViewPosition.cancelPosition
        
        signupButton.transform = CGAffineTransform.init(scaleX: 0.0, y: 1)
        cancelButton.transform = CGAffineTransform.init(scaleX: 0.0, y: 1)
        signupButton.isHidden = true
        cancelButton.isHidden = true
    }
    
    fileprivate func loadViews() {
        let borderWidth: CGFloat = 2
        let borderColor = UIColor.black.cgColor
        
        logoImage = UIImageView(frame: CGRect(x: self.view.frame.size.width * 0.36, y: self.view.frame.size.height * 0.05, width: 90, height: 90))
        logoImage.image = UIImage(named: "Sneaks")
        self.view.addSubview(logoImage)
        
        nameTextField = CustomTextField(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.06))
        nameTextField.layer.borderWidth = borderWidth
        nameTextField.layer.borderColor = borderColor
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = UIColor.white
        nameTextField.font = UIFont(name: "Optima-Bold", size: 12)
        nameTextField.attributedPlaceholder = NSAttributedString(string: " Enter name")
        self.view.addSubview(nameTextField)
        
        emailTextField = CustomTextField(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.06))
        emailTextField.backgroundColor = UIColor.white
        emailTextField.keyboardType = .emailAddress
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.font = UIFont(name: "Optima-Bold", size: 12)
        emailTextField.layer.borderWidth = borderWidth
        emailTextField.layer.borderColor = borderColor
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.attributedPlaceholder = NSAttributedString(string: " Enter email")
        self.view.addSubview(emailTextField)
        
        passwordTextField = CustomTextField(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.06))
        passwordTextField.font = UIFont(name: "Optima-Bold", size: 12)
        passwordTextField.layer.borderWidth = borderWidth
        passwordTextField.layer.borderColor = borderColor
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: " Enter password")
        self.view.addSubview(passwordTextField)
        
        
        loginButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.4, height: self.view.frame.size.height * 0.06))
        self.view.addSubview(loginButton)
        loginButton.layer.borderWidth = borderWidth
        loginButton.layer.borderColor = borderColor
        loginButton.backgroundColor = UIColor.white
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        loginButton.setTitleColor(UIColor.themeblack, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        newuserButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.06))
        self.view.addSubview(newuserButton)
        newuserButton.titleLabel?.textAlignment = .center
        newuserButton.setTitle("New User? Click here to sign up", for: .normal)
        newuserButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        newuserButton.setTitleColor(UIColor.white, for: .normal)
        newuserButton.addTarget(self, action: #selector(newuserButtonAction), for: .touchUpInside)
        
        signupButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.4, height: self.view.frame.size.height * 0.06))
        self.view.addSubview(signupButton)
        signupButton.layer.borderWidth = borderWidth
        signupButton.layer.borderColor = borderColor
        signupButton.backgroundColor = UIColor.themeblack
        signupButton.setTitle("Signup", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        
        cancelButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.4, height: self.view.frame.size.height * 0.06))
        cancelButton.layer.borderWidth = borderWidth
        cancelButton.layer.borderColor = borderColor
        self.view.addSubview(cancelButton)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        cancelButton.setTitleColor(UIColor.themeblack, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        forgotPasswordButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * 0.4, height: self.view.frame.size.height * 0.06))
        self.view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot Password", for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        forgotPasswordButton.setTitleColor(UIColor.themeblack, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
    }
}
