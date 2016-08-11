# EasyToast

![Swift 2.0](https://img.shields.io/badge/Swift-2.2-orange.svg)
[![CI Status](http://img.shields.io/travis/Franco Meloni/EasyToast.svg?style=flat)](https://travis-ci.org/Franco Meloni/EasyToast)
[![Version](https://img.shields.io/cocoapods/v/EasyToast.svg?style=flat)](http://cocoapods.org/pods/EasyToast)
[![License](https://img.shields.io/cocoapods/l/EasyToast.svg?style=flat)](http://cocoapods.org/pods/EasyToast)
[![Platform](https://img.shields.io/cocoapods/p/EasyToast.svg?style=flat)](http://cocoapods.org/pods/EasyToast)

Android-like toast with simple interface, using a toast queue to handle multiple toasts allowing to push or present a ViewController without disappear 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EasyToast is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EasyToast"
```


## Show Toasts

### Show default toasts

```swift
self.view.showToast("Toast Text", position: .Bottom, popTime: 5, dismissOnTap: false)
self.view.showToast("Toast Text", position: .Bottom, popTime: kToastNoPopupTime, dismissOnTap: true)
```

### Personalize toasts

```swift
self.view.showToast("Toast Text", position: .Bottom, popTime: 5, dismissOnTap: false, bgColor: UIColor.blackColor(), textColor: UIColor.whiteColor(), font: UIFont.boldSystemFontOfSize(19))
self.view.showToast("Toast Text", position: .Bottom, popTime: kToastNoPopupTime, dismissOnTap: true, bgColor: UIColor.redColor(), textColor: UIColor.blackColor(), font: UIFont.boldSystemFontOfSize(19))
```

### Personalize all toasts in view

```swift
self.view.toastBackgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
self.view.toastTextColor = UIColor.redColor()
self.view.toastFont = UIFont.boldSystemFontOfSize(19)

self.view.showToast("Toast Text", position: .Bottom, popTime: 5, dismissOnTap: false)
self.view.showToast("Toast Text", position: .Bottom, popTime: kToastNoPopupTime, dismissOnTap: true)
```

## Screenshots

![EasyToast Screenshot](https://raw.github.com/f-meloni/EasyToast/master/Screenshots/EasyToastScreenshots.png)

## Author

Franco Meloni, franco.meloni91@gmail.com

## License

EasyToast is available under the MIT license. See the LICENSE file for more info.
