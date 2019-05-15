//
//  SplashScreen.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        counter()
        // Do any additional setup after loading the view.
    }
    
    private func counter(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            if UserDefaults.standard.string(forKey: "sessionID") != nil {
                AppDelegate.shared.rootViewController.switchToMainScreen()
            } else {
                AppDelegate.shared.rootViewController.switchToLogout()
            }
        }
    }
    
}
