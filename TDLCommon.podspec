Pod::Spec.new do |s|
  s.name         = "TDLCommon"
  s.version      = "1.0.5"
  s.summary      = "Some common classes created by TDL."
  s.homepage     = "https://github.com/krinApc/TDLCommon"
  s.license      = "MIT"
  s.author       = { "k_rin" => "k_rin@ap-com.co.jp" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/krinApc/TDLCommon.git", :tag => "1.0" }
  s.source_files = "Classes", "Classes/**/*.{h,m}"

  # s.resources  = "Resources/*.png"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  s.dependency 'AFNetworking', "~> 2.5"
  s.dependency 'UIAlertView+Blocks'
  s.dependency 'UIActionSheet+Blocks'

end
