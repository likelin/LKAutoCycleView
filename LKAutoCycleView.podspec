#
#  Be sure to run `pod spec lint LKAutoCycleView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "LKAutoCycleView"
  spec.version      = "0.0.1"
  spec.summary      = "LKAutoCycleView is the view who can auto cycle with configed duration"


  spec.description  = <<-DESC
	this is  a nice view when using in project
                   DESC

  spec.homepage     = "https://github.com/likelin/LKAutoCycleView"

  spec.license      = "MIT"


  spec.author             = { "kelin" => "likelin_work@163.com" }


  spec.source       = { :git => "https://github.com/likelin/LKAutoCycleView.git", :tag => "#{spec.version}" }

  spec.platform     = :ios, "11.0"

  spec.source_files  = "Demo/Core/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  spec.requires_arc = true

end
