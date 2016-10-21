//
//  EasyToastConfiguration.swift
//  Pods
//
//  Created by Franco Meloni on 03/10/16.
//
//

import Foundation

/**
EasyToast configuration class
**/
open class EasyToastConfiguration {
    /**
    Padding between borders and toast content
    **/
    open static var toastInnerPadding: CGFloat = 10
    
    /**
    Toast animation duration
    **/
    open static var animationDuration: TimeInterval = 0.6
    
    /**
    Toast animation damping ratio
    **/
    open static var dampingRatio: CGFloat = 0.65
    
    /**
    Toast animation initial spring velocity
    **/
    open static var initialSpringVelocity: CGFloat = 0.07
}
