//
//  LoginVC.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/13/19.
//

import UIKit
import Foundation

class LoginVC: BaseVC {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userName.delegate = self
        password.delegate = self
        borderBottom(textField: userName, color: UIColor().underlineGray)
        borderBottom(textField: password, color: UIColor().underlineGray)
        
    }

    @IBAction func showOrHidePassword(_ sender: Any) {
        password.togglePasswordVisibility()
        password.isSecureTextEntry ? showPassword.setImage(#imageLiteral(resourceName: "closeEye"), for: UIControl.State.normal) : showPassword.setImage(#imageLiteral(resourceName: "openEye"), for: UIControl.State.normal)
    }
    
    func enableButtonAndTextFields(){
        loginButton.loadingIndicator(false)
        password.allowsEditingTextAttributes = true
        userName.allowsEditingTextAttributes = true
        showPassword.isUserInteractionEnabled = true
    }
    
    func disableButtonAndTextFields(){
        loginButton.loadingIndicator(true)
        password.allowsEditingTextAttributes = false
        userName.allowsEditingTextAttributes = false
        showPassword.isUserInteractionEnabled = false
    }
    
    func getSessionId(request_token: String){
        let parameters = [
            "request_token": request_token
        ]
        var headers = [requestHeaders]()
        headers.append(requestHeaders(key:"Content-Type",value:"application/json"))
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(Constants.api.api_key.rawValue)", method: .post, parameters: parameters, headers: headers, success: { (res) in
            self.enableButtonAndTextFields()
            let sessionID = (res["session_id"] as! String)
            UserDefaults.standard.set(sessionID, forKey: "sessionID")
            AppDelegate.shared.rootViewController.switchToMainScreen()
        }) { (error) in
            self.enableButtonAndTextFields()
            self.Alert(title: "Error!", message: error["status_message"] as? String ?? "Error", VC: self)
        }
    }
    
    func loginAction(request_token: String){
        let parameters = [
            "username": userName.text!,
            "password": password.text!,
            "request_token": request_token
            ]
        var headers = [requestHeaders]()
        headers.append(requestHeaders(key:"Content-Type",value:"application/json"))
        NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(Constants.api.api_key.rawValue)", method: .post, parameters: parameters, headers: headers, success: { (res) in
            self.getSessionId(request_token: res["request_token"] as! String)
        }) { (error) in
            self.enableButtonAndTextFields()
            self.Alert(title: "Error!", message: error["status_message"] as? String ?? "Error", VC: self)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        disableButtonAndTextFields()
        if userName.text == "" {
            enableButtonAndTextFields()
            Alert(title: "Complete", message: "Please Insert Your User Name.", VC: self)
        } else if password.text == "" {
            enableButtonAndTextFields()
            Alert(title: "Complete", message: "Please Insert Your Password.", VC: self)
        } else if NetworkManager.sharedInstance.isConnected() {
            NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/token/new?api_key=\(Constants.api.api_key.rawValue)", method: .get, success: { (res) in
                self.loginAction(request_token: res["request_token"] as! String)
            }) { (error) in
                self.enableButtonAndTextFields()
                self.Alert(title: "Error!", message: "sdsd", VC: self)
            }
        } else {
            enableButtonAndTextFields()
            Alert(title: "Error!", message: "Please Connect to the Internet..", VC: self)
        }
    }
    
    
}

