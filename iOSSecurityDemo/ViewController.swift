//
//  ViewController.swift
//  iOSSecurityDemo
//
//  Created by Chhaileng Peng on 2/23/19.
//  Copyright © 2019 Chhaileng Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginScreen = storyboard?.instantiateInitialViewController()
        appDelegate.window?.rootViewController = loginScreen
    }
    
}

