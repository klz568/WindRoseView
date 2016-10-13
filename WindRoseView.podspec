Pod::Spec.new do |s|
s.name             = "WindRoseView"
s.version          = "1.0.0"
s.summary          = "A marquee view used on iOS."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/klz568/WindRoseView"
s.license          = 'MIT'
s.author           = { "KLZ" => "kongling1126@qq.com" }
s.source           = { :git => "https://github.com/klz568/WindRoseView.git", :tag => s.version.to_s }

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'WindRoseView/*'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end
