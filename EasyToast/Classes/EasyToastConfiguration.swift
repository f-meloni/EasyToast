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
public class EasyToastConfiguration {
    /**
    Padding between borders and toast content
    **/
    public static var toastInnerPadding: CGFloat = 10
    
    /**
    Toast animation duration
    **/
    public static var animationDuration: NSTimeInterval = 0.6
    
    /**
    Toast animation damping ratio
    **/
    public static var dampingRatio: CGFloat = 0.65
    
    /**
    Toast animation initial spring velocity
    **/
    public static var initialSpringVelocity: CGFloat = 0.07
}