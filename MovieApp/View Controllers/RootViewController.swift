//
//  RootViewController.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Proerties
    
    private var current: UIViewController
    
    // MARK: - Init
    
    init() {
        self.current = UIStoryboard(name: "SplashScreen", bundle: nil).instantiateViewController(withIdentifier: "SplashScreen") as! SplashScreenViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.current = UIStoryboard(name: "SplashScreen", bundle: nil).instantiateViewController(withIdentifier: "SplashScreen") as! SplashScreenViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    private func showLoginScreen() {
        let new = UINavigationController(rootViewController: LoginViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    func switchToMainScreen() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        let mainScreen = UINavigationController(rootViewController: mainViewController)
        mainScreen.isNavigationBarHidden = true
        animateDismissTransition(to: mainScreen)
    }
    
    func switchToLogout() {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        logoutScreen.isNavigationBarHidden = true
        animateDismissTransition(to: logoutScreen)
    }
    
}
