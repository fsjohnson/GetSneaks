//
//  Login.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/25/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class Login: UIView {
    
    let borderWidth: CGFloat = 2
    let borderColor = UIColor.black.cgColor
    var signupButtonState = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLoginPositions()
        emailTextField.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setLoginPositions() {
        // logo image
        self.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // email text field
        self.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // password text field
        self.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // name text field
        self.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        nameTextField.transform = CGAffineTransform.init(scaleX: 0.0, y: 1)
        
        // login button
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // forgot password text field
        self.addSubview(forgotPasswordButton)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // sign up button
        self.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        signupButton.isHidden = true
    
        // new user button
        self.addSubview(newuserButton)
        newuserButton.translatesAutoresizingMaskIntoConstraints = false
        newuserButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        newuserButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        newuserButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newuserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // cancel button
        self.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cancelButton.isHidden = true
    }
    
    func newuserButtonAction(_ sender: UIButton) {
        animateForSignup()
    }
    
    func cancelButtonAction(_ sender: UIButton) {
        animateForLogin()
    }
    
    fileprivate func animateForSignup() {
        nameTextField.isHidden = false
        signupButton.isHidden = false
        cancelButton.isHidden = false
        forgotPasswordButton.isHidden = true
        newuserButton.isUserInteractionEnabled = false
        self.cancelButton.isUserInteractionEnabled = false
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
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
                self.setLoginPositions()
                
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
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 90))
        image.image = UIImage(named: "transparentSneaks")
        image.layer.borderColor = UIColor.themeMediumBlue.cgColor
        image.layer.borderWidth = 2.0
        return image
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = UIColor.white
        textField.keyboardType = .emailAddress
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont(name: "Optima-Bold", size: 12)
        textField.layer.borderWidth = self.borderWidth
        textField.layer.borderColor = self.borderColor
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: " Enter email")
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.font = UIFont(name: "Optima-Bold", size: 12)
        textField.layer.borderWidth = self.borderWidth
        textField.layer.borderColor = self.borderColor
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: " Enter password")
        return textField
    }()
    
    lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.layer.borderWidth = self.borderWidth
        textField.layer.borderColor = self.borderColor
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.font = UIFont(name: "Optima-Bold", size: 12)
        textField.attributedPlaceholder = NSAttributedString(string: " Enter name")
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = self.borderWidth
        button.layer.borderColor = self.borderColor
        button.backgroundColor = UIColor.white
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        button.setTitleColor(UIColor.themeblack, for: .normal)
        return button
    }()
    
    lazy var newuserButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitle("New User? Click here to sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(newuserButtonAction), for: .touchUpInside)
        return button
    }()
    
    var signupButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.themeblack.cgColor
        button.backgroundColor = UIColor.themeblack
        button.setTitle("Signup", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.themeblack.cgColor
        button.backgroundColor = UIColor.white
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        button.setTitleColor(UIColor.themeblack, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()
    
    var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima-Bold", size: 12)
        button.setTitleColor(UIColor.themeblack, for: .normal)
        return button
    }()
}

