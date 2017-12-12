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
    fileprivate lazy var button : UIButton = {
        let button = UIButton(type: .system)
        
        button.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitle("Send Toasts", for: UIControlState())
        button.addTarget(self, action: #selector(showToast), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.button)
        
        EasyToastConfiguration.toastInnerPadding = 10
        EasyToastConfiguration.animationDuration = 0.6
        EasyToastConfiguration.initialSpringVelocity = 0.07
        EasyToastConfiguration.dampingRatio = 0.65
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.button.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showToast() {
        self.view.toastBackgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.toastTextColor = UIColor.white
        self.view.toastFont = UIFont.boldSystemFont(ofSize: 19)
        
        self.view.showToast("Toast", position: .bottom, popTime: 1.5, dismissOnTap: false)
        self.view.showToast("Dismiss on tap toast", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: true, bgColor: UIColor.red.withAlphaComponent(0.7), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 19))
        self.view.showToast("Long Text Toast:\n" +
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas vitae elit non leo pellentesque feugiat. Cras nec volutpat massa, nec blandit nisi. Etiam ut hendrerit purus. Morbi accumsan, risus ut cursus finibus, quam ipsum egestas nisl, vel hendrerit massa justo nec metus. Cras pulvinar, leo eu pulvinar convallis, tellus felis laoreet massa, ac tincidunt orci massa non odio. Ut pulvinar dictum metus quis mollis. Aenean tincidunt sit amet turpis sed egestas. Morbi porta dolor neque, ut pellentesque urna semper id.",
                            position: .bottom,
                            popTime: 5,
                            dismissOnTap: true,
                            bgColor: UIColor.red.withAlphaComponent(0.7),
                            textColor: UIColor.white,
                            font: UIFont.systemFont(ofSize: 19))
        
    }

    func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
}

