Pod::Spec.new do |s|
  s.name                  = "Progressable"
  s.version               = "0.0.3"
  s.summary               = "Add an horizontal loading bar to any UIView"

  s.description           = "Lightweight component to create an horizontal loading line on any UIView."

  s.homepage              = "https://github.com/MartinMoizard/Progressable"
  s.screenshots           = "https://cloud.githubusercontent.com/assets/395477/18714291/9620e9a0-8015-11e6-9552-34b2bc9b8467.gif"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = "Martin Moizard"

  s.ios.deployment_target = "8.0"
  s.source                = { :git => "https://github.com/MartinMoizard/Progressable.git", :tag => s.version.to_s }

  s.source_files          = "Source/*.swift"
  s.requires_arc          = true
end
