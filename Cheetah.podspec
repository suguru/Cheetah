Pod::Spec.new do |s|
  s.name         = "Cheetah"
  s.version      = "0.1.2"
  s.summary      = "Easy animation library on iOS with Swift 2.0"

  s.description  = <<-DESC
                   Cheetah is an animation library which uses CADisplayLink to animate any properties.
                   DESC

  s.homepage     = "https://github.com/suguru/Cheetah"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"
  s.author       = { "Suguru Namura" => "snamura@gmail.com" }
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"

  s.source       = { :git => "https://github.com/suguru/Cheetah.git", :tag => "0.1.2" }

  s.source_files  = "Classes", "Cheetah/*.swift"

end
