//
//  Toast.swift
//  Pods
//
//  Created by Franco Meloni on 08/08/16.
//
//

import Foundation

class QueueToast {
    var message: String
    var position: ToastPosition
    var popTime: UInt64?
    var dismissOnTap: Bool
    var text: String?
    var bgColor: UIColor?
    var textColor: UIColor?
    var font: UIFont?

    init(message: String, position: ToastPosition, popTime: UInt64?, dismissOnTap: Bool, bgColor: UIColor? = nil, textColor: UIColor? = nil, font: UIFont? = nil) {
        self.message = message
        self.position = position
        self.popTime = popTime
        self.dismissOnTap = dismissOnTap
        self.bgColor = bgColor
        self.textColor = textColor
        self.font = font
    }
}

