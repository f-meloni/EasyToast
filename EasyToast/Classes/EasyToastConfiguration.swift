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
    public static var toastInnerPadding: CGFloat = 10

    /**
     Toast animation duration
     **/
    public static var animationDuration: TimeInterval = 0.6

    /**
     Toast animation damping ratio
     **/
    public static var dampingRatio: CGFloat = 0.65

    /**
     Toast animation initial spring velocity
     **/
    public static var initialSpringVelocity: CGFloat = 0.07

    /**
     Toast is using safe area to be sure that is shown correctly
     **/
    public static var useSafeArea: Bool = true
}
