platform :ios,'10.0'
use_frameworks!

pod 'SwiftMessages'
pod 'FCAlertView'
pod 'Eureka', '~> 4.1.0'
pod 'DatePickerDialog'

post_install do |installer|
installer.pods_project.build_configurations.each do |config|
config.build_settings.delete('CODE_SIGNING_ALLOWED')
config.build_settings.delete('CODE_SIGNING_REQUIRED')
end
end

target 'SNSApp' do

end
