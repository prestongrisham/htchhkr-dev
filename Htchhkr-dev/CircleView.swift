//
//  CircleView.swift
//  Htchhkr-dev
//
//  Created by Preston Grisham on 7/28/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit


class CircleView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
        
    }
    
}
