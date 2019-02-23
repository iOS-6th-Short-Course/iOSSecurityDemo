//
//  LoginViewController.swift
//  iOSSecurityDemo
//
//  Created by Chhaileng Peng on 2/23/19.
//  Copyright © 2019 Chhaileng Peng. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var touchIdButton: UIButton!
    
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let support = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
        if !support {
            touchIdButton.isHidden = true
        } else {
            if context.biometryType == .faceID {
                touchIdButton.setImage(#imageLiteral(resourceName: "faceid"), for: .normal)
            }
        }
        
    }
    

    @IBAction func login(_ sender: Any) {
        if let username = usernameTextField.text,
            let password = passwordTextField.text {
            
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username)
            
            do {
                let correctPass = try passwordItem.readPassword()
                if password == correctPass {
//                    title = "Login Success"
                    
                    // open welcome screen
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let welcomeScreen = storyboard?.instantiateViewController(withIdentifier: "welcome") as! ViewController
                    appDelegate.window?.rootViewController = welcomeScreen
                    UserDefaults.standard.set(true, forKey: "isLogin")
                } else {
                    title = "Incorrect Password"
                }
            } catch {
                title = "User not found"
            }
        }
    }
    
    @IBAction func touchid(_ sender: Any) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use TouchID or FaceID to login to this App") { (success, error) in
            if success {
                print("Success")
                DispatchQueue.main.async {
                    // open welcome screen
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let welcomeScreen = self.storyboard?.instantiateViewController(withIdentifier: "welcome") as! ViewController
                    appDelegate.window?.rootViewController = welcomeScreen
                    UserDefaults.standard.set(true, forKey: "isLogin")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
