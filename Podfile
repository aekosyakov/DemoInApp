source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
inhibit_all_warnings!

platform :ios, '11.0'

target 'DemoScreen' do
pod 'Firebase/Analytics'
pod 'Firebase/RemoteConfig'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end

