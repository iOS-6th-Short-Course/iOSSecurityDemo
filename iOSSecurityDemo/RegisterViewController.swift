//
//  RegisterViewController.swift
//  iOSSecurityDemo
//
//  Created by Chhaileng Peng on 2/23/19.
//  Copyright © 2019 Chhaileng Peng. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        if let username = usernameTextField.text,
            let password = passwordTextField.text {
            
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username)
            do {
                try passwordItem.savePassword(password)
                print("Register success!")
                navigationController?.popViewController(animated: true)
            } catch {
                print("Register faied!")
            }
            
        }
    }
    

}
