//
//  CenterVCDelegate.swift
//  Htchhkr-dev
//
//  Created by Preston Grisham on 7/28/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import Foundation
import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}

