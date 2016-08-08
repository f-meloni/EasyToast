//
//  UIView+Toast.swift
//  Pods
//
//  Created by Franco Meloni on 05/08/16.
//
//

import Foundation

public extension UIView {
    private struct AssociatedKeys {
        static var toastWindow = "toastWindow"
        static var toastBackgroundColor = "toastWindow"
        static var toastTextColor = "toastTextColor"
        static var toastFont = "toastFont"
        static var toastDuration = "toastDuration"
        static var toastQueue = "toastQueue"
        static var hasDiplayedToast = "hasDiplayedToast"
    }
    
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
                queueToast.font = self.toastFont
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
            
            let popTime = toast.popTime ?? kToastNoPopupTime
            
            self.toastWindow = ToastWindow(frame: UIScreen.mainScreen().bounds)
            self.toastWindow?.toast = toast
            
            self.toastWindow?.onToastDimissed = { toastWindow in
                dispatch_sync(lockQueue) {
                    let toast = toastWindow.toast
                    
                    self.toastWindow = nil
                    
                    self.toastQueue = self.toastQueue.filter() { $0 !== toast } ?? []
                    
                    self.hasDiplayedToast = false
                    
                    print(toast)
                    print(toastQueue)
                    
                    if let queueToast = self.toastQueue.first {
                        self.showToast(queueToast)
                    }
                }
            }
            
            self.hasDiplayedToast = true
            
            self.toastWindow?.show()
            
            if (toast.popTime ?? kToastNoPopupTime) != kToastNoPopupTime {
                let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(popTime * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), {
                    self.toastWindow?.dismiss()
                })
            }
        }
    }
    
    
    //MARK: Getters and Setters
    
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
}