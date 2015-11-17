Pod::Spec.new do |s|
  s.name         = "TDLCommon"
  s.version      = "0.0.1"
  s.summary      = "Some common classes created by TDL."
  s.homepage     = "https://github.com/krinApc/TDLCommon"
  s.license      = "MIT"
  s.author       = { "k_rin" => "k_rin@ap-com.co.jp" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/krinApc/TDLCommon.git", :tag => "0.0.1" }
  s.source_files = "Classes", "Classes/**/*.{h,m}"

  # s.resources  = "Resources/*.png"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  s.dependency "AFNetworking"
  s.dependency "UIAlertView+Blocks"

end
