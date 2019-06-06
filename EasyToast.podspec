#
# Be sure to run `pod lib lint EasyToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EasyToast'
  s.version          = '3.0.0'
  s.summary          = 'Swift Android like toasts'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift Android-like toast with simple interface, using a toast queue to handle multiple toasts allowing to push or present a ViewController without disappear
                       DESC

  s.homepage         = 'https://github.com/f-meloni/EasyToast'
  s.screenshots      = 'https://raw.github.com/f-meloni/EasyToast/master/Screenshots/EasyToastScreenshots.jpg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Franco Meloni' => 'franco.meloni@xorovo.com' }
  s.source           = { :git => 'https://github.com/f-meloni/EasyToast.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'EasyToast/Classes/**/*'
  s.xcconfig = { 'SWIFT_VERSION' => '5.0' }
  
  # s.resource_bundles = {
  #   'EasyToast' => ['EasyToast/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
