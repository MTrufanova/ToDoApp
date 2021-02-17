source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
inhibit_all_warnings!

use_frameworks!

target 'ToDoList' do
  pod 'SnapKit', '~> 4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end