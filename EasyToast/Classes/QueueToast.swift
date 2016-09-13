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
    var tag: String?
    var position: ToastPosition
    var popTime: Double?
    var dismissOnTap: Bool
    var text: String?
    var bgColor: UIColor?
    var textColor: UIColor?
    var font: UIFont?

    init(message: String, tag: String?, position: ToastPosition, popTime: Double?, dismissOnTap: Bool, bgColor: UIColor? = nil, textColor: UIColor? = nil, font: UIFont? = nil) {
        self.message = message
        self.tag = tag
        self.position = position
        self.popTime = popTime
        self.dismissOnTap = dismissOnTap
        self.bgColor = bgColor
        self.textColor = textColor
        self.font = font
    }
}

