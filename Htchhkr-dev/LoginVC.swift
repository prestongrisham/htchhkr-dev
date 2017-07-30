//
//  LoginVC.swift
//  Htchhkr-dev
//
//  Created by Preston Grisham on 7/29/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    var tap: UITapGestureRecognizer!
    
    @IBOutlet weak var emailTextField: RoundedCornerTextField!
    @IBOutlet weak var passwordTextField: RoundedCornerTextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var authButton: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.bindToKeyboard()
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }

    @IBAction func CancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func authBtnPressed(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            authButton.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                            if self.segmentControl.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.providerID] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider": user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated: Success")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    print(errorCode)
                                }
                            } else {
                                if let user = user {
                                    if self.segmentControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider": user.providerID] as [String: Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider": user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                print("Successfully created user!")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}
