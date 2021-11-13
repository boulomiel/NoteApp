//
//  LoginViewController.swift
//  tabsandpage
//
//  Created by Ruben Mimoun on 11/11/2021.
//

import Foundation
import UIKit

class LoginViewController : AuthFieldViewController, AuthPageStoryboard{
    
    @IBOutlet weak var logintextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    lazy var loginHandler = LoginHandler(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldsArr(fields: [logintextField, passwordTextField])
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email =  logintextField.text, email.count > 0 ,
              let password =  passwordTextField.text, password.count > 0 else {
                  Router.showError(title: Title.login, messageString: Message.register)
                  return
              }
        loginHandler.proceedLogin(email: email, password: password)
    }
}

extension LoginViewController : LoginHandlerDelegate{
    
    func onLoginSuccess(user: MoveoUser?) {
        DispatchQueue.main.async {
            Router.showNotesTabs(user: user)
        }
    }
    
    func onLoginError(error: AuthError) {
        Router.showError(title: error.title, messageString: error.message){[weak self] in
            self?.cleanField()
        }
    }
}