#
# Be sure to run `pod lib lint MultiPagedController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MultiPagedController'
  s.version          = '1.0.1'
  s.summary          = 'MultiPagedController gives ability to create simple paged controller.'
  s.description      = <<-DESC
MultiPagedController is a simple framework that allows you to create page controllers without doing extra work
                       DESC

  s.homepage         = 'https://github.com/RomanTheBaby/MultiPagedController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RomanTheBaby' => 'mailofrom@gmail.com' }
  s.source           = { :git => 'https://github.com/RomanTheBaby/MultiPagedController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'MultiPagedController/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.swift_version = '4.2'
end
