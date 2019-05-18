//
//  AccountVC.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit
import ViewAnimator

class AccountViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var imageView: UIView!
    
    // MARK: - Properties
    private let zoomAnimation = AnimationType.zoom(scale: 0.2)
    private let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    private let fromAnimation = AnimationType.from(direction: .top, offset: 250.0)
    private var profile: Account = Account.init(fromDictionary: [:])
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
    }
    
    // MARK: - GetProgileMethod
    
    func getProfileData(){
        guard NetworkManager.sharedInstance.isConnected() else {
            if let profileData = UserDefaults.standard.dictionary(forKey: "profile") {
                profile = Account.init(fromDictionary: profileData)
                setUpData()
            } else {
                faildCall()
                Alert(title: "Error!", message: "Please Connect to the Internet..", VC: self)
            }
            return
        }
        loading.startAnimating()
        contentView.isHidden = true
        AccountManager.getProfile(completionHandler: { (res, error) in
            if error != nil {
                if error!["status_code"] as? Int == 3 {
                    self.logOut()
                } else if let profileData = UserDefaults.standard.dictionary(forKey: "profile") {
                    self.profile = Account.init(fromDictionary: profileData)
                    self.setUpData()
                    self.successCall()
                } else {
                    self.faildCall()
                    self.Alert(title: "Error!", message: error!["status_message"] as? String ?? "Error", VC: self)
                }
                return
            }
            self.profile = Account.init(fromDictionary: res!)
            UserDefaults.standard.set(res, forKey: "profile")
            self.setUpData()
            self.successCall()
        })
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func reloadProfile(_ sender: Any) {
        getProfileData()
    }
    
    @IBAction func logOut(_ sender: Any) {
        AlertWith2ButtonsAndActionFirstButton(title: "😞", message: "you want to logOut ?", VC: self, B1Action: {
            guard NetworkManager.sharedInstance.isConnected() else {
                self.Alert(title: "Error!", message: "Please Connect to the Internet..", VC: self)
                return
            }
            AccountManager.logOut(completionHandler: { (done, error) in
                if error != nil {
                    self.Alert(title: "Error!", message: error!, VC: self)
                    return
                }
                self.logOut()
            })
        }, B1Title: "YES", B2Title: "NO")
    }
    
    
}

// MARK: - Private Functions

extension AccountViewController {
    
    private func logOut(){
        UserDefaults.standard.removeObject(forKey: "sessionID")
        UserDefaults.standard.removeObject(forKey: "profile")
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    private func setUpData(){
        self.avatarImage.kf.indicatorType = .activity
        self.avatarImage.kf.setImage(with: URL(string: self.profile.gravatar), placeholder: #imageLiteral(resourceName: "placeholder"))
        UIView.animate(views: [imageView],
                       animations: [rotateAnimation, zoomAnimation],
                       duration: 0.5)
        self.name.text = self.profile.name
        self.userName.text = self.profile.username
        UIView.animate(views: [detailsView],
                       animations: [fromAnimation],
                       duration: 0.5)
    }
    
    private func faildCall(){
        self.loading.stopAnimating()
        self.contentView.isHidden = true
        self.reloadButton.isHidden = false
    }
    
    private func successCall(){
        self.loading.stopAnimating()
        self.contentView.isHidden = false
        self.reloadButton.isHidden = true
    }
    
}
