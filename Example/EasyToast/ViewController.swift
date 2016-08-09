//
//  ViewController.swift
//  EasyToast
//
//  Created by Franco Meloni on 08/05/2016.
//  Copyright (c) 2016 Franco Meloni. All rights reserved.
//

import UIKit
import EasyToast

class ViewController: UIViewController {
    private lazy var button : UIButton = {
        let button = UIButton(type: .System)
        
        button.frame = CGRectMake(100, 100, 100, 100)
        
        button.setTitle("Send Toasts", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: #selector(showToast), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    private lazy var button2 : UIButton = {
        let button = UIButton(type: .System)
        
        button.frame = CGRectMake(200, 100, 100, 100)
        
        button.backgroundColor = UIColor.greenColor()
        button.titleLabel?.text = "Toast"
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.addTarget(self, action: #selector(pushTestVC), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.button)
        self.view.addSubview(self.button2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showToast() {
        self.view.toastBackgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.view.toastTextColor = UIColor.whiteColor()
        self.view.toastFont = UIFont.boldSystemFontOfSize(19)
        
        self.view.showToast("Prova di toast", position: .Bottom, popTime: 5, dismissOnTap: false)
        self.view.showToast("Prova di toast2", position: .Bottom, popTime: kToastNoPopupTime, dismissOnTap: true, bgColor: UIColor.redColor().colorWithAlphaComponent(0.7), textColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(19))
        self.view.showToast("Prova di toast3", position: .Bottom, popTime: 5, dismissOnTap: false, bgColor: UIColor.blackColor().colorWithAlphaComponent(0.7), textColor: UIColor.whiteColor(), font: UIFont.boldSystemFontOfSize(19))
    }
    
    func pushTestVC() {
        self.presentViewController(TestVCViewController(), animated: true, completion: nil)
    }

}

