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
    private struct AssociatedKeys {
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
            - position: Toast screen position
            - popTime: Time before toast pop
            - dismissOnTap: Defines if toast will be dismissed with tap
            - bgColor: Toast background color
            - textColor: Toast Text Color
            - font: Toast font
    */
    public func showToast(message: String, position: ToastPosition, popTime: UInt64?, dismissOnTap: Bool, bgColor: UIColor? = nil, textColor: UIColor? = nil, font: UIFont? = nil) {
        let queueToast = QueueToast(message: message, position: position, popTime: popTime, dismissOnTap: dismissOnTap, bgColor: bgColor, textColor: textColor, font: font)
        
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
        
        self.dynamicType.showToast(queueToast)
    }
    
    private class func showToast(toast: QueueToast) {
        let lockQueue = dispatch_queue_create("easyToast.toast.queue", nil)
        dispatch_sync(lockQueue) {
            if hasDiplayedToast ?? false {
                self.toastQueue.append(toast)
                return
            }
            
            let popTime = toast.popTime ?? kToastNoPopTime
            
            self.toastWindow = ToastWindow(frame: UIScreen.mainScreen().bounds)
            self.toastWindow?.toast = toast
            
            self.toastWindow?.onToastDimissed = { toastWindow in
                dispatch_sync(lockQueue) {
                    let toast = toastWindow.toast
                    
                    self.toastTimer?.invalidate()
                    
                    self.toastTimer = nil
                    self.toastWindow = nil
                    
                    self.toastQueue = self.toastQueue.filter() { $0 !== toast } ?? []
                    
                    self.hasDiplayedToast = false
                    
                    if let queueToast = self.toastQueue.first {
                        self.showToast(queueToast)
                    }
                }
            }
            
            self.hasDiplayedToast = true
            
            self.toastWindow?.show()
            
            if popTime != kToastNoPopTime {
                self.toastTimer = NSTimer.scheduledTimerWithTimeInterval(Double(popTime), target: self, selector: #selector(dismissToast), userInfo: nil, repeats: false)
            }
        }
    }
    
    
    //MARK: Class Getters and Setters
    
    private class var hasDiplayedToast: Bool {
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
    
    private class var toastQueue: [QueueToast] {
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
    
    private class var toastTimer: NSTimer? {
        get {
            guard let toastTimer = objc_getAssociatedObject(self, &AssociatedKeys.toastTimer) as? NSTimer else {
                return nil
            }
            return toastTimer
        }
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.toastTimer,value,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private class var toastWindow: ToastWindow? {
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
    class func dismissToast() {
        self.toastWindow?.dismiss()
    }
}