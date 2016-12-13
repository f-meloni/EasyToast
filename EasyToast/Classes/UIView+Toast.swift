//
//  UIView+Toast.swift
//  Pods
//
//  Created by Franco Meloni on 05/08/16.
//
//

import Foundation

/**
 Toast extension for UIView
**/
public extension UIView {
    fileprivate struct AssociatedKeys {
        static var toastWindow = "toastWindow"
        static var toastBackgroundColor = "toastWindow"
        static var toastTextColor = "toastTextColor"
        static var toastFont = "toastFont"
        static var toastDuration = "toastDuration"
        static var toastQueue = "toastQueue"
        static var toastTimer = "toastTimer"
        static var hasDiplayedToast = "hasDiplayedToast"
    }
    
    /**
        Shows toast on view
        
        - Parameters:
            - message: Message to show
            - tag: Toast tag to avoid multiple toasts with same tag
            - position: Toast screen position
            - popTime: Time before toast pop
            - dismissOnTap: Defines if toast will be dismissed with tap
            - bgColor: Toast background color
            - textColor: Toast Text Color
            - font: Toast font
    */
    public func showToast(_ message: String, tag: String? = nil, position: ToastPosition, popTime: Double?, dismissOnTap: Bool, bgColor: UIColor? = nil, textColor: UIColor? = nil, font: UIFont? = nil) {
        let queueToast = QueueToast(message: message, tag: tag, position: position, popTime: popTime, dismissOnTap: dismissOnTap, bgColor: bgColor, textColor: textColor, font: font)
        
        if bgColor == nil {
            if let toastBackgroundColor = self.toastBackgroundColor {
                queueToast.bgColor = toastBackgroundColor
            }
        }
        
        if textColor == nil {
            if let textColor = self.toastTextColor {
                queueToast.textColor = textColor
            }
        }
        
        if font == nil {
            if let font = self.toastFont {
                queueToast.font = font
            }
        }
        
        type(of: self).showToast(queueToast)
    }
    
    fileprivate class func showToast(_ toast: QueueToast) {
        let lockQueue = DispatchQueue(label: "easyToast.toast.queue", attributes: [])
        lockQueue.sync {
            guard !self.hasDisplayedToast else {
                var appendToast = true
                
                if let toastTag = toast.tag {
                    if self.toastQueue.contains(where: { queueToast in queueToast.tag == toastTag }) {
                        appendToast = false
                    }
                }
                
                if appendToast {
                    self.toastQueue.append(toast)
                }
                
                return
            }
            
            let popTime = toast.popTime ?? kToastNoPopTime
            
            self.toastWindow = ToastWindow(frame: UIScreen.main.bounds)
            self.toastWindow?.toast = toast
            
            self.toastWindow?.onToastDimissed = { toastWindow in
                lockQueue.sync {
                    let toast = toastWindow.toast
                    
                    self.toastTimer?.invalidate()
                    
                    self.toastTimer = nil
                    self.toastWindow = nil
                    
                    self.toastQueue = self.toastQueue.filter() { $0 !== toast } 
                    
                    self.hasDisplayedToast = false
                    
                    if let queueToast = self.toastQueue.first {
                        self.showToast(queueToast)
                    }
                }
            }
            
            self.hasDisplayedToast = true
            
            self.toastQueue.append(toast)
            
            self.toastWindow?.show()
            
            if popTime != kToastNoPopTime {
                self.toastTimer = Timer.scheduledTimer(timeInterval: popTime, target: self, selector: #selector(dismissToast), userInfo: nil, repeats: false)
            }
        }
    }
    
    
    //MARK: Class Getters and Setters
    
    fileprivate class var hasDisplayedToast: Bool {
        get {
            guard let toastQueue = objc_getAssociatedObject(self, &AssociatedKeys.hasDiplayedToast) as? Bool else {
                return false
            }
            return toastQueue
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.hasDiplayedToast,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal class var toastQueue: [QueueToast] {
        get {
            guard let toastQueue = objc_getAssociatedObject(self, &AssociatedKeys.toastQueue) as? [QueueToast] else {
                return [QueueToast]()
            }
            return toastQueue
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastQueue,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate class var toastTimer: Timer? {
        get {
            guard let toastTimer = objc_getAssociatedObject(self, &AssociatedKeys.toastTimer) as? Timer else {
                return nil
            }
            return toastTimer
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastTimer,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal class var toastWindow: ToastWindow? {
        get {
            guard let toastWindow = objc_getAssociatedObject(self, &AssociatedKeys.toastWindow) as? ToastWindow else {
                return nil
            }
            return toastWindow
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastWindow,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     Defines if there is already a displayed toast in view
    */
    public var hasDisplayedToast: Bool {
        get {
            return UIView.hasDisplayedToast
        }
    }
    
    //MARK: Getters and Setters
    
    /** 
    View toasts default background color
    */
    public var toastBackgroundColor : UIColor? {
        get {
            guard let toastBackgroundColor = objc_getAssociatedObject(self, &AssociatedKeys.toastBackgroundColor) as? UIColor else {
                return nil
            }
            return toastBackgroundColor
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastBackgroundColor,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
    View toasts default text color
    */
    public var toastTextColor : UIColor? {
        get {
            guard let toastTextColor = objc_getAssociatedObject(self, &AssociatedKeys.toastTextColor) as? UIColor else {
                return nil
            }
            return toastTextColor
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastTextColor,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
    View toasts default font
    */
    public var toastFont: UIFont? {
        get {
            guard let toastFont = objc_getAssociatedObject(self, &AssociatedKeys.toastFont) as? UIFont else {
                return nil
            }
            return toastFont
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastFont,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //MARK: Dismiss Toast
    
    /**
        Dismiss currently shown toast
    */
    public func dismissToast() {
        UIView.dismissToast()
    }
    
    /**
     Class method to dismiss currently shown toast
    */
    internal class func dismissToast() {
        self.toastWindow?.dismiss()
    }
}
