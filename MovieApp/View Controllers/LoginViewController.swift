//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/13/19.
//

import UIKit
import Foundation

class LoginViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var userName: UITextField!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var showPassword: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
    }
    
    // MARK: - IBActions
    
    @IBAction private func showOrHidePassword(_ sender: Any) {
        password.togglePasswordVisibility()
        password.isSecureTextEntry ? showPassword.setImage(#imageLiteral(resourceName: "closeEye"), for: UIControl.State.normal) : showPassword.setImage(#imageLiteral(resourceName: "openEye"), for: UIControl.State.normal)
    }
    
    @IBAction private func login(_ sender: Any) {
        guard let userName = userName.text, !userName.isEmpty else {
            Alert(title: "Complete", message: "Please Insert Your User Name.", VC: self)
            return
        }
        
        guard let passwordValue = password.text, !passwordValue.isEmpty, passwordValue.count > 3 else {
            Alert(title: "Complete", message: "Please Insert Your Password.", VC: self)
            return
        }
        
        guard NetworkManager.sharedInstance.isConnected() else {
            Alert(title: "Error!", message: "Please Connect to the Internet..", VC: self)
            return
        }
        
        disableButtonAndTextFields()
        AuthenticationManager.getAPIToken { (token, error) in
            if error != nil {
                self.enableButtonAndTextFields()
                self.Alert(title: "Error!", message: "Couldn't get api token!", VC: self)
                return
            }
            
            self.loginAction(request_token: token!)
        }
    }
    
}

// MARK: - Private Functions

extension LoginViewController {
    private func configureTextFields() {
        userName.delegate = self
        password.delegate = self
        borderBottom(textField: userName, color: UIColor().underlineGray)
        borderBottom(textField: password, color: UIColor().underlineGray)
    }
    
    private func enableButtonAndTextFields() {
        loginButton.loadingIndicator(false)
        password.isUserInteractionEnabled = true
        userName.isUserInteractionEnabled = true
        showPassword.isUserInteractionEnabled = true
    }
    
    private func disableButtonAndTextFields() {
        loginButton.loadingIndicator(true)
        password.isUserInteractionEnabled = false
        userName.isUserInteractionEnabled = false
        showPassword.isUserInteractionEnabled = false
    }
    
    private func getSessionId(request_token: String) {
        
        AuthenticationManager.getSessionId(apiToken: request_token) { shouldNavigateToHome, error in
            if error != nil {
                self.enableButtonAndTextFields()
                self.Alert(title: "Error!", message: error!, VC: self)
                return
            }
            
            self.enableButtonAndTextFields()
            if (shouldNavigateToHome != nil) {
                AppDelegate.shared.rootViewController.switchToMainScreen()
            }
        }
    }
    
    private func loginAction(request_token: String) {
        guard let userName = userName.text, !userName.isEmpty else {
            Alert(title: "Complete", message: "Please Insert Your User Name.", VC: self)
            return
        }
        
        guard let passwordValue = password.text, !passwordValue.isEmpty, passwordValue.count > 3 else {
            Alert(title: "Complete", message: "Please Insert Your Password.", VC: self)
            return
        }
        
        AuthenticationManager.login(userName: userName, password: passwordValue, requestToken: request_token) { requestToken, error in
            if error != nil {
                self.enableButtonAndTextFields()
                self.Alert(title: "Error!", message: error!, VC: self)
                return
            }
            
            self.getSessionId(request_token: requestToken!)
        }
    }
}
