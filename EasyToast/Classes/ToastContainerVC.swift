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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIApplication.sharedApplication().statusBarStyle
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return UIApplication.sharedApplication().statusBarHidden
    }
}
