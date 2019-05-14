//
//  ViewController.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/13/19.
//

import UIKit
import Foundation

class ViewController: BaseVC {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var showPassword: UIButton!
    
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
    
    @IBAction func login(_ sender: Any) {
        
    }
    
    
}

