Pod::Spec.new do |s|
  s.name         = "MBTraitCollection"
  s.version      = "0.1.0"
  s.summary      = "UIViewController category that provides safe iOS7 compatible access to UITraitCollection"

  s.description  = <<-DESC
											UIViewController category that provides safe iOS7 compatible access to UITraitCollection 
											object by exposing new property mbTraitCollection on all UIViewControllers.
                   DESC

  s.homepage     = "https://github.com/MatejBalantic/MBTraitCollection"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author             = { "Matej Balantič" => "matej@balantic.si" }
  s.social_media_url = "http://twitter.com/skavt"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/MatejBalantic/MBTraitCollection.git", :tag => "#{s.version}" }
  s.source_files  = 'Classes', 'MBLocationManager/Classes/*.{h,m}'
  s.requires_arc = true
end
