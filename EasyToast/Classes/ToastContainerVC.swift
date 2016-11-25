//
//  ToastContainerVC.swift
//  Pods
//
//  Created by Franco Meloni on 26/08/16.
//
//

import UIKit

class ToastContainerVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.statusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return UIApplication.shared.isStatusBarHidden
    }
}
