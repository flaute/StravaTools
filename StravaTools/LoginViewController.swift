//
//  LoginViewController.swift
//  StravaTools
//
//  Created by Csaba Szigeti on 2020. 05. 16..
//  Copyright © 2020. Csaba Szigeti. All rights reserved.
//

import UIKit
import SwiftUI

final class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = !StravaAPIClient.sharedInstance.isLoggedIn()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        StravaAPIClient.sharedInstance.authenticate(self) { error in
            print("error : \(String(describing: error))")
        }
    }
    
    private func showResult(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBAction func currentAthleteButtonPressed(_ sender: Any) {
        StravaAPIClient.sharedInstance.currentAthlete { (json, error) in
            if error != nil {
                self.showResult("Error", String(describing: error))
                return
            }
            
            self.showResult("Success", String(describing: json))
        }
    }
}

extension LoginViewController: UIViewControllerRepresentable {
    public typealias UIViewControllerType = LoginViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginViewController>) -> LoginViewController {
        return LoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: UIViewControllerRepresentableContext<LoginViewController>) {
    }
}
