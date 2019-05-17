//
//  SplashScreen.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit

class SplashScreen: UIViewController {
    
    // MARK: - Properties
    
    private let splashScreenTimerLenght: Int = 2
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter()
    }
    
    // MARK: Functions
    
    private func counter() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(splashScreenTimerLenght)) {
            if UserDefaults.standard.string(forKey: "sessionID") != nil {
                AppDelegate.shared.rootViewController.switchToMainScreen()
            } else {
                AppDelegate.shared.rootViewController.switchToLogout()
            }
        }
    }
    
}
