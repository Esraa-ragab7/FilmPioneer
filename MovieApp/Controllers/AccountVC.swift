//
//  AccountVC.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/16/19.
//

import UIKit

class AccountVC: BaseVC {
    // MARK: - outlet
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: - variables
    var profile: Account = Account.init(fromDictionary: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
    }
    
    // MARK: - GetProgileMethods
    func getProfileData(){
        if NetworkManager.sharedInstance.isConnected() {
            loading.startAnimating()
            contentView.isHidden = true
            let session_id = UserDefaults.standard.string(forKey: "sessionID")
            NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/account?api_key=\(Constants.api.api_key.rawValue)&session_id=\(session_id ?? "")", success: { (res) in
                self.profile = Account.init(fromDictionary: res)
                UserDefaults.standard.set(res, forKey: "profile")
                self.setUpData()
                self.successCall()
            }) { (error) in
                if let profileData = UserDefaults.standard.dictionary(forKey: "profile") {
                    self.profile = Account.init(fromDictionary: profileData)
                    self.setUpData()
                } else {
                    self.faildCall()
                    self.Alert(title: "Error!", message: error["status_message"] as? String ?? "Error", VC: self)
                }
            }
        } else {
            if let profileData = UserDefaults.standard.dictionary(forKey: "profile") {
                profile = Account.init(fromDictionary: profileData)
                setUpData()
            } else {
                faildCall()
                Alert(title: "Error!", message: "Please Connect to the Internet..", VC: self)
            }
        }
    }
    
    func setUpData(){
        self.avatarImage.kf.indicatorType = .activity
        self.avatarImage.kf.setImage(with: URL(string: self.profile.gravatar), placeholder: #imageLiteral(resourceName: "placeholder"))
        self.name.text = self.profile.name
        self.userName.text = self.profile.username
    }
    
    func faildCall(){
        self.loading.stopAnimating()
        self.contentView.isHidden = true
        self.reloadButton.isHidden = false
    }
    
    func successCall(){
        self.loading.stopAnimating()
        self.contentView.isHidden = false
        self.reloadButton.isHidden = true
    }
    
    // MARK: - Button Actions
    @IBAction func reloadProfile(_ sender: Any) {
        getProfileData()
    }
    
    @IBAction func logOut(_ sender: Any) {
        AlertWith2ButtonsAndActionFirstButton(title: "😞", message: "you want to logOut ?", VC: self, B1Action: {
            if NetworkManager.sharedInstance.isConnected() {
                let parameters = [
                    "session_id": UserDefaults.standard.string(forKey: "sessionID")
                ]
                var headers = [requestHeaders]()
                headers.append(requestHeaders(key:"Content-Type",value:"application/json"))
                
                NetworkManager.sharedInstance.serverRequests(url: "https://api.themoviedb.org/3/authentication/session?api_key=\(Constants.api.api_key.rawValue)", method: .delete, parameters: parameters as [String : Any], headers: headers, success: { (res) in
                    AppDelegate.shared.rootViewController.switchToLogout()
                }) { (error) in
                    self.Alert(title: "Error!", message: error["status_message"] as? String ?? "Error", VC: self)
                }
            } else {
                self.Alert(title: "Error!", message: "Please Connect to the Internet..", VC: self)
            }
        }, B1Title: "YES", B2Title: "NO")
    }

}
