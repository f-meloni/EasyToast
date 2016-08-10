//
//  ToastWindow.swift
//  Pods
//
//  Created by Franco Meloni on 05/08/16.
//
//

import UIKit

public enum ToastPosition {
    case Bottom
    case Top
}

private let kMaxToastWidth: CGFloat = UIDevice.currentDevice().userInterfaceIdiom == .Pad ? 500 : 300
private let kPadding: CGFloat = 10
private let kToastDistance: CGFloat = 100

public let kToastNoPopupTime : UInt64 = 0

class ToastWindow: UIWindow {
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: CGRectMake(kPadding, kPadding, CGRectGetHeight(self.toastView.frame) - (kPadding * 2), CGRectGetWidth(self.toastView.frame) - (kPadding * 2)))
        textLabel.numberOfLines = 0
        textLabel.font = self.font
        textLabel.textColor = self.textColor
        
        return textLabel
    }()
    
    private lazy var toastView: UIView = {
        let toastView = UIView(frame: CGRectZero)
        
        toastView.backgroundColor = self.toastBgColor
        toastView.layer.cornerRadius = 5
        toastView.clipsToBounds = true
        
        return toastView
    }()
    
    private lazy var containerVC: UIViewController = {
        let containerVC = UIViewController(nibName: nil, bundle: nil)
        containerVC.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        containerVC.view.addSubview(self.toastView)
        
        return containerVC
    }()
    
    private let oldWindow: UIWindow?
    
    var toast: QueueToast? {
        didSet {
            let popTime = toast?.popTime ?? kToastNoPopupTime
            
            self.text = toast?.message
            self.toastPosition = toast?.position ?? .Bottom
            self.dismissOnTap = popTime == kToastNoPopupTime ? true : toast?.dismissOnTap ?? false
            
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
    
    var toastPosition: ToastPosition = .Bottom
    
    var dismissOnTap: Bool = false {
        didSet {
            self.userInteractionEnabled = self.dismissOnTap
        }
    }
    
    var text: String? {
        didSet {
            self.textLabel.text = self.text
        }
    }
    
    var toastBgColor: UIColor = UIColor.blackColor().colorWithAlphaComponent(0.7) {
        didSet {
            self.toastView.backgroundColor = self.toastBgColor
        }
    }
    
    var font: UIFont = UIFont.systemFontOfSize(19) {
        didSet {
            self.textLabel.font = self.font
        }
    }
    
    var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.textLabel.textColor = self.textColor
        }
    }
    
    var onToastDimissed: ((toast: ToastWindow) -> ())?
    
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    private func commonInit() {
        self.opaque = false
        self.backgroundColor = UIColor.clearColor()
        self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.windowLevel = UIWindowLevelNormal
        self.rootViewController = self.containerVC
        self.toastView.addSubview(self.textLabel)
        self.userInteractionEnabled = false
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(windowTapped))
        self.addGestureRecognizer(self.tapGestureRecognizer!)
    }
    
    override init(frame: CGRect) {
        self.oldWindow = UIApplication.sharedApplication().keyWindow
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.oldWindow = UIApplication.sharedApplication().keyWindow
        
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.toastView.frame = self.toastEndPosition()
    }
    
    func show() {
        self.makeKeyAndVisible()
        self.containerVC.view.frame = UIScreen.mainScreen().applicationFrame
        
        self.toastView.frame = self.toastStartPosition()
        
        self.textLabel.frame = CGRectMake(kPadding, kPadding, CGRectGetWidth(self.toastView.frame) - (kPadding * 2), CGRectGetHeight(self.toastView.frame) - (kPadding * 2))
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.07, options: .TransitionNone, animations: {
            self.toastView.frame = self.toastEndPosition()
            }, completion: nil)
    }
    
    
    public func dismiss() {
        let lockQueue = dispatch_queue_create("easyToast.toast.dismissQueue", nil)
        dispatch_sync(lockQueue) { [weak self] in
            UIView.animateWithDuration(0.6, animations: {
                self?.toastView.frame = self?.toastStartPosition() ?? CGRectZero
            }) { (success) in
                self?.hidden = true
                self?.oldWindow?.makeKeyAndVisible()
                self?.resignKeyWindow()
                
                if let onToastDimissed = self?.onToastDimissed {
                    onToastDimissed(toast: self ?? ToastWindow())
                }
            }
        }
    }
    
    //MARK: Actions
    
    func windowTapped() {
        self.userInteractionEnabled = false
        self.dismiss()
    }
    
    //MARK: Private
    
    private func textSize() -> CGSize {
        var size = self.textLabel.sizeThatFits(CGSizeMake(kMaxToastWidth, CGFloat.max))
        
        return size
    }
    
    private func rectWithY(y: CGFloat) -> CGRect {
        let size = self.textSize()
        
        let viewWidth = (size.width + kPadding * 2)
        
        return CGRectMake((CGRectGetWidth(self.bounds) - viewWidth)/2, y, viewWidth, size.height +  kPadding * 2)
    }
    
    private func toastStartPosition() -> CGRect {
        if toastPosition == .Top {
            return self.rectWithY(-self.textSize().height)
        }
        else {
            return self.rectWithY(CGRectGetHeight(self.bounds))
        }
    }

    private func toastEndPosition() -> CGRect {
        if toastPosition == .Top {
            return self.rectWithY(kToastDistance)
        }
        else {
            return self.rectWithY(CGRectGetHeight(self.bounds) - kToastDistance - self.textSize().height)
        }
    }
}
