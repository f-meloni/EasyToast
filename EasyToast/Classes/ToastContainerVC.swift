//
//  ToastContainerVC.swift
//  Pods
//
//  Created by Franco Meloni on 26/08/16.
//
//

import UIKit

class ToastContainerVC: UIViewController {
    var statusBarStyle: UIStatusBarStyle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.statusBarStyle ?? .Default
    }
}
