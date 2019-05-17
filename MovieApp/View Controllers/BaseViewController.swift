//
//  BaseVC.swift
//  MovieApp
//
//  Created by Esraa Mohamed Ragab on 5/14/19.
//

import UIKit

class BaseViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func Alert(title:String , message:String,VC :UIViewController) {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        VC.present(alert, animated: true, completion: nil)
    }
    
    
    func AlertWith2ButtonsAndActionFirstButton(title:String , message:String,VC :UIViewController,B1Action: @escaping () -> Void,B1Title:String,B2Title:String)  {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: UIAlertController.Style.alert)
        let YesLogout = UIAlertAction(title: B1Title, style: .default) { (alert: UIAlertAction!) -> Void in
            B1Action()
        }
        alert.addAction(YesLogout)
        alert.addAction(UIAlertAction(title: B2Title, style: .default, handler: nil))
        VC.present(alert, animated: true, completion: nil)
        
    }
    
    func AlertWith1ButtonAndAction(title:String , message:String,VC :UIViewController,B1Action: @escaping () -> Void,B1Title:String)  {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: UIAlertController.Style.alert)
        let YesLogout = UIAlertAction(title: B1Title, style: .default) { (alert: UIAlertAction!) -> Void in
            B1Action()
        }
        alert.addAction(YesLogout)
        VC.present(alert, animated: true, completion: nil)
    }
    
    func AlertWith2ButtonsAndActions(title:String , message:String,VC :UIViewController,B1Action: @escaping () -> Void,B2Action: @escaping () -> Void,B1Title:String,B2Title:String)  {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: UIAlertController.Style.alert)
        let YesLogout = UIAlertAction(title: B1Title, style: .default) { (alert: UIAlertAction!) -> Void in
            B1Action()
        }
        alert.addAction(YesLogout)
        let NoLogout = UIAlertAction(title: B2Title, style: .default) { (alert: UIAlertAction!) -> Void in
            B2Action()
        }
        alert.addAction(NoLogout)
        VC.present(alert, animated: true, completion: nil)
        
    }
    
    func borderBottom(textField: UITextField, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    func keyboardWillShow(notification :Notification, scroll: UIScrollView) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height , right: 0)
        scroll.contentInset = contentInset
    }
    
    func keyboardWillHide(notification : Notification, scroll: UIScrollView){
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scroll.contentInset = contentInset
    }
    
    func removeObserver(scroll: UIScrollView) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addAbserver(scroll: UIScrollView)  {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification : notification, scroll: scroll)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification : notification, scroll: scroll)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
