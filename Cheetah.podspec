Pod::Spec.new do |s|
  s.name         = "Cheetah"
  s.version      = "0.1.0"
  s.summary      = "Easy animation library on iOS with Swift2"

  s.description  = <<-DESC
                   Cheetah is an animation library which uses CADisplayLink to animate any properties.
                   DESC

  s.homepage     = "https://github.com/suguru/Cheetah"

  s.license      = "MIT"
  s.author       = { "Suguru Namura" -> "snamura@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/suguru/Cheetah.git", :tag => s.version }

  s.source_files  = "Cheetah/*.swift"
end
