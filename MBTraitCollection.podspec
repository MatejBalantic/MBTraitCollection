Pod::Spec.new do |s|
  s.name         = "MBTraitCollection"
  s.version      = "0.1.0"
  s.summary      = "UIViewController category provides iOS7 compatible access to UITraitCollection object by exposing new property mbTraitCollection."

  s.description  = <<-DESC
					Trait collections are new as of iOS 8 and even if they compile with the latest SDK even for deployment targets older than 8.0, their use will cause crash in iOS 7 application. This renders them unusefull until application deployment target is restricted to 8.0.

                    To solve that problem, I've created a category on UIViewController which exposes a new property mbTraitCollection. When accessing this property a backwards-compatible MBTraitCollection class will be lazy-loaded for you. Class is basically a wrapper around UITraitCollection and will use native behavior when possible (i.e. in iOS >= 8). On older iOS version, this class will use other available techniques to determine device characteristics for you, thus allowing you to use trait collection even on iOS 7.
                   DESC

  s.homepage     = "https://github.com/MatejBalantic/MBTraitCollection"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author             = { "Matej Balantič" => "matej@balantic.si" }
  s.social_media_url = "http://twitter.com/skavt"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/MatejBalantic/MBTraitCollection.git", :tag => "#{s.version}" }
  s.source_files  = 'MBTraitCollection/Classes/*.{h,m}'
  s.requires_arc = true
end
