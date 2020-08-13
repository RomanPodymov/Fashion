Pod::Spec.new do |s|
  s.name             = "Fashion"
  s.summary          = "Fashion accessories and beauty tools to share and reuse UI styles in a Swifty way"
  s.version          = "4.0.0"
  s.homepage         = "https://github.com/vadymmarkov/Fashion"
  s.license          = 'MIT'
  s.author           = { "Vadym Markov" => "markov.vadym@gmail.com" }
  s.source           = {
    :git => "https://github.com/vadymmarkov/Fashion.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/vadymmarkov'

  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '9.0'

  s.requires_arc = true
  s.ios.source_files = 'Sources/{iOS,Shared}/**/*'
  s.osx.source_files = 'Sources/{Mac,Shared}/**/*'
  s.tvos.source_files = 'Sources/{iOS,tvOS,Shared}/**/*'

  s.ios.frameworks = 'UIKit', 'Foundation'
  s.tvos.frameworks = 'UIKit', 'Foundation'
  s.osx.frameworks = 'Cocoa', 'Foundation'

  s.swift_versions = ['5.0']

end
