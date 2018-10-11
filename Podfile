platform :ios,'10.0'
use_frameworks!

target 'SNSApp' do
    pod 'SwiftMessages', '5.0.0'
    pod 'FCAlertView'
    pod 'Eureka', '4.1.0'
    pod 'Alamofire', '~> 4.7'
    pod 'AlamofireObjectMapper', '~> 5.0'
    pod 'AlamofireImage'
    pod 'PopupDialog', '~> 0.9'
end



post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

