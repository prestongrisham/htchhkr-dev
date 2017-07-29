//
//  LoginVC.swift
//  Htchhkr-dev
//
//  Created by Preston Grisham on 7/29/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}
