//
//  ToastWindow.swift
//  Pods
//
//  Created by Franco Meloni on 05/08/16.
//
//

import UIKit

/**
 Toast screen position
 
 - Bottom: Toast will be shown on the bottom of the screen
 - Top: Toast will be shown on the top of the screen
*/
public enum ToastPosition {
    /**
     Toast will be shown on the bottom of the screen
    */
    case bottom
    
    /**
     Toast will be shown on the top of the screen
    */
    case top
}

private let kMaxToastWidth: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 500 : 280

private let kToastDistance: CGFloat = 100

/**
 No pop time for toast
 */
public let kToastNoPopTime : Double = 0

class ToastWindow: UIWindow {
    fileprivate lazy var textLabel: UILabel = {
        let padding = EasyToastConfiguration.toastInnerPadding
        
        let textLabel = UILabel(frame: CGRect(x: padding, y: padding, width: self.toastView.frame.height - (padding * 2), height: self.toastView.frame.width - (padding * 2)))
        textLabel.numberOfLines = 0
        textLabel.font = self.font
        textLabel.textColor = self.textColor
        
        return textLabel
    }()
    
    fileprivate lazy var toastView: UIView = {
        let toastView = UIView(frame: CGRect.zero)
        
        toastView.backgroundColor = self.toastBgColor
        toastView.layer.cornerRadius = 5
        toastView.clipsToBounds = true
        
        return toastView
    }()
    
    fileprivate lazy var containerVC: UIViewController = {
        let containerVC = ToastContainerVC(nibName: nil, bundle: nil)
        containerVC.view.addSubview(self.toastView)
        
        return containerVC
    }()
    
    fileprivate let oldWindow: UIWindow?
    
    var toast: QueueToast? {
        didSet {
            let popTime = toast?.popTime ?? kToastNoPopTime
            
            self.text = toast?.message
            self.toastPosition = toast?.position ?? .bottom
            self.dismissOnTap = popTime == kToastNoPopTime ? true : toast?.dismissOnTap ?? false
            
            if let toastBackgroundColor = toast?.bgColor  {
                self.toastBgColor = toastBackgroundColor
            }
            
            if let toastTextColor = toast?.textColor  {
                self.textColor = toastTextColor
            }
            
            if let font = toast?.font {
                self.font = font
            }
        }
    }
    
    var toastPosition: ToastPosition = .bottom
    
    var dismissOnTap: Bool = false {
        didSet {
            self.isUserInteractionEnabled = self.dismissOnTap
        }
    }
    
    var text: String? {
        didSet {
            self.textLabel.text = self.text
        }
    }
    
    var toastBgColor: UIColor = UIColor.black.withAlphaComponent(0.7) {
        didSet {
            self.toastView.backgroundColor = self.toastBgColor
        }
    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 19) {
        didSet {
            self.textLabel.font = self.font
        }
    }
    
    var textColor: UIColor = UIColor.white {
        didSet {
            self.textLabel.textColor = self.textColor
        }
    }
    
    var onToastDimissed: ((_ toast: ToastWindow) -> ())?
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer?
    
    fileprivate func commonInit() {
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.windowLevel = UIWindowLevelNormal
        self.rootViewController = self.containerVC
        self.toastView.addSubview(self.textLabel)
        self.isUserInteractionEnabled = false
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(windowTapped))
        self.addGestureRecognizer(self.tapGestureRecognizer!)
    }
    
    override init(frame: CGRect) {
        self.oldWindow = UIApplication.shared.keyWindow
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.oldWindow = UIApplication.shared.keyWindow
        
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.toastView.frame = self.toastEndPosition()
    }
    
    func show() {
        self.makeKeyAndVisible()
        self.containerVC.view.frame = UIScreen.main.applicationFrame
        
        self.toastView.frame = self.toastStartPosition()
        
        let padding = EasyToastConfiguration.toastInnerPadding
        
        self.textLabel.frame = CGRect(x: padding, y: padding, width: self.toastView.frame.width - (padding * 2), height: self.toastView.frame.height - (padding * 2))
        
        UIView.animate(withDuration: EasyToastConfiguration.animationDuration, delay: 0, usingSpringWithDamping: EasyToastConfiguration.dampingRatio, initialSpringVelocity: EasyToastConfiguration.initialSpringVelocity, options: UIViewAnimationOptions(), animations: {
            self.toastView.frame = self.toastEndPosition()
            }, completion: nil)
    }
    
    
    func dismiss() {
        let lockQueue = DispatchQueue(label: "easyToast.toast.dismissQueue", attributes: [])
        lockQueue.sync { [weak self] in
            UIView.animate(withDuration: EasyToastConfiguration.animationDuration, delay: 0, usingSpringWithDamping: EasyToastConfiguration.dampingRatio, initialSpringVelocity: EasyToastConfiguration.initialSpringVelocity, options: UIViewAnimationOptions(), animations: {
                self?.toastView.frame = self?.toastStartPosition() ?? CGRect.zero
            }) { (success) in
                self?.isHidden = true
                self?.oldWindow?.makeKeyAndVisible()
                self?.resignKey()
                
                if let onToastDimissed = self?.onToastDimissed {
                    onToastDimissed(self ?? ToastWindow())
                }
            }
        }
    }
    
    //MARK: Actions
    
    func windowTapped() {
        self.isUserInteractionEnabled = false
        self.dismiss()
    }
    
    //MARK: Private
    
    fileprivate func textSize() -> CGSize {
        let size = self.textLabel.sizeThatFits(CGSize(width: kMaxToastWidth, height: CGFloat.greatestFiniteMagnitude))
        
        return size
    }
    
    fileprivate func rectWithY(_ y: CGFloat) -> CGRect {
        let size = self.textSize()
        
        let padding = EasyToastConfiguration.toastInnerPadding
        
        let viewWidth = (size.width + padding * 2)
        
        return CGRect(x: (self.bounds.width - viewWidth)/2, y: y, width: viewWidth, height: size.height +  padding * 2)
    }
    
    fileprivate func toastStartPosition() -> CGRect {
        if toastPosition == .top {
            return self.rectWithY(-self.textSize().height - EasyToastConfiguration.toastInnerPadding * 2 - UIApplication.shared.statusBarFrame.size.height)
        }
        else {
            return self.rectWithY(self.bounds.height)
        }
    }

    fileprivate func toastEndPosition() -> CGRect {
        if toastPosition == .top {
            return self.rectWithY(kToastDistance)
        }
        else {
            return self.rectWithY(self.bounds.height - kToastDistance - self.textSize().height -  EasyToastConfiguration.toastInnerPadding * 2)
        }
    }
}
